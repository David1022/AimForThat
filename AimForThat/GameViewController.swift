//
//  ViewController.swift
//  AimForThat
//
//  Created by David Mendaño on 18/5/18.
//  Copyright © 2018 David Mendaño. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    let EXTRA_POINTS : Int = 1000
    
    
    var currentValue : Int!
    var targetValue = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        self.currentValue = lroundf(sender.value)
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        let difference : Int = abs(self.currentValue - self.targetValue)
        let points = (difference > 0) ? (100 - difference) : self.EXTRA_POINTS
        self.score += points
        
        let alert = UIAlertController(title: "Has ganado: ",
                                      message: "\(points) puntos", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
        
        startNewRound()
        updateLabels()
    }
    
    func startNewRound() {
        self.currentValue = 50
        self.slider.value = Float (self.currentValue)
        self.targetValue = 1 + Int(arc4random_uniform(100))
        self.round += 1
    }
    
    func updateLabels() {
        self.targetLabel.text = "\(self.targetValue)"
        self.scoreLabel.text = "\(self.score)"
        self.roundLabel.text = "\(self.round)"
    }
}

