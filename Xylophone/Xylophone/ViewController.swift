//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func notePressed(_ sender: UIButton) {
        var soundFileName : String = "C"
        
        switch sender.tag {
        case 2:
            soundFileName = "D"
            break
            
        case 3:
            soundFileName = "E"
            break
            
        case 4:
            soundFileName = "F"
            break
            
        case 5:
            soundFileName = "G"
            break
            
        case 6:
            soundFileName = "A"
            break
            
        case 7:
            soundFileName = "B"
            break
            
        default:
            soundFileName = "D"
            break
        }
        
        guard let xylophoneSound = Bundle.main.url(forResource: soundFileName, withExtension: "wav") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                audioPlayer = try AVAudioPlayer(contentsOf: xylophoneSound, fileTypeHint: AVFileType.wav.rawValue)

                guard let audioPlayer = audioPlayer else { return }

                audioPlayer.play()

            } catch let error {
                print(error.localizedDescription)
            }
    }
    
}

