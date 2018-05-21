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
        
        setupSlider()
        resetGame()
        updateLabels()
    }
    
    func setupSlider() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackRightImage = UIImage(named: "SliderTrackRight")
        
        self.slider.setThumbImage(thumbImageNormal, for: .normal)
        self.slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let inset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: inset)
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: inset)
        
        self.slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        self.slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
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
        var points = 100 - difference
        
        var title : String
        switch difference {
        case 0:
            title = "Perfecto!"
            points = Int (10.0 * Float (points))
        case 1...3:
            title = "Casi perfecto"
            points = Int (1.5 * Float (points))
        case 4...5:
            title = "Ha faltado poco..."
            points = Int (1.2 * Float (points))
        default:
            title = "Has estado un lejos"
        }
        
        self.score += points

        let alert = UIAlertController(title: title,
                                      message: "Has ganado \(points) puntos", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Aceptar", style: .default, handler:
        {action in
            self.startNewRound()
            self.updateLabels()
        })
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    @IBAction func startNewGame(_ sender: Any) {
        resetGame()
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
    
    func resetGame() {
        self.score = 0
        self.round = 0
        startNewRound()
    }
}

