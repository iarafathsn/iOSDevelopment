//
//  ViewController.swift
//  Magic8Ball
//
//  Created by Arafat Hossain on 23/7/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ballImageView: UIImageView!
    
    var randomBallNumber : Int = 0
    let ballArray : [String] = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBallImage()
    }

    @IBAction func askButtonPressed(_ sender: UIButton) {
        updateBallImage()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateBallImage()
    }
    
    func updateBallImage() {
        randomBallNumber = Int(arc4random_uniform(5))
        
        print("random \(randomBallNumber)")
        
        ballImageView.image = UIImage(named: ballArray[randomBallNumber])
    }
}

