//
//  ViewController.swift
//  simonSays
//
//  Created by ALEJANDRO MORENO on 9/19/18.
//  Copyright © 2018 ALEJANDRO MORENO. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet var colorDisplays: [UIView]!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var colorsFrame: UIView!
    
    var sound: AVAudioPlayer?
    var timer = Timer()
    var pattern = [Int]()
    var index = 0
    var playerTurn = false
    var gameOver = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(fileName: "start")
    }
    
    @IBAction func onColorTapped(_ sender: UITapGestureRecognizer) {
        if playerTurn {
            for number in 0..<colorDisplays.count{
                if colorDisplays[number].frame.contains(sender.location(in: colorsFrame)){
                    if pattern[index] == number {
                        flashColor(number: number)
                        index += 1
                        if index == pattern.count {
                            index = 0
                            playerTurn = false
                            messageLabel.text = ""
                            addToPattern()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                                self.displayPattern()
                            }
                        }
                    }
                    else {
                        messageLabel.text = "Game Over"
                        gameOver = true
                        playSound(fileName: "lose")
                        restart()
                    }
                }
            }
        }
    }
    
    
    @IBAction func onStartButtonTapped(_ sender: Any) {
        if gameOver {
            restart()
            displayPattern()
            gameOver = false
            startButton.alpha = 0.0
            messageLabel.text = ""
        }
    }
    
    func addToPattern() {
        pattern.append(Int(arc4random_uniform(4)))
    }
    
    func restart() {
        pattern.removeAll()
        index = 0
        addToPattern()
        startButton.alpha = 1.0
    }
    
    func playSound(fileName: String){
        if let path = Bundle.main.path(forResource: fileName, ofType: "wav"){
            let url = URL(fileURLWithPath: path)
            do{
                self.sound = try AVAudioPlayer(contentsOf: url)
                self.sound?.play()
            }
            catch {
                print("Can't find file")
            }
        }
    }
    
    func flashColor(number: Int) {
        self.playSound(fileName: String(number))
        UIView.transition(with: colorDisplays[number], duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.colorDisplays[number].alpha = 1.0
        }) {(true) in
            UIView.transition(with: self.colorDisplays[number], duration: 0.2, options: .transitionCrossDissolve, animations: {self.colorDisplays[number].alpha = 0.4
            }, completion: nil)
        }
    }
    
    func displaypattern(){
        timer = Timer()
    }
    
    @objc func nextColor(){
        if index < pattern.count {
            flashColor(number: pattern[index])
            index += 1
        }
        else {
            timer.invalidate()
            index = 0
            playerTurn = true
            messageLabel.text = "Your Turn"
        }
    }
    
    func displayPattern(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector (ViewController.nextColor)), userInfo: nil, repeats: true)
    }
}

