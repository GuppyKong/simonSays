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
       }
    @IBAction func onColorTapped(_ sender: UITapGestureRecognizer) {
    }
    @IBAction func onStartButtonTapped(_ sender: Any) {
    }
    
    
    
    

}

