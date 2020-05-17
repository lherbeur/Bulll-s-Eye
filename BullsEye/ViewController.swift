//
//  ViewController.swift
//  BullsEye
//
//  Created by Olawunmi GEORGE on 5/1/20.
//  Copyright © 2020 Olawunmi GEORGE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var topScore: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var randomGuess: UILabel!
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var round: UILabel!
    
    var roundCounter = 0;
    var scoreVal = 0;
    
    var sliderGuess = 0;
    var randomNum = Int.random(in: 1...100);
    
    var top_score_ = UserDefaults.standard;
    
    
    @IBAction func showAlert(_ sender: Any) {
        
        let score = calcScore(target: randomNum, actual: sliderGuess)
        let extra = (score == 100) ? 100 : 0
        
        
        let title = (score == 100) ? ("Perfect!") : (score >= 95 ? "Almost!" : "Not even close!")
        
        let alertCtrler = UIAlertController(title:
            title, message: "The value of the slider is \(sliderGuess)." + "\nYou were to guess \(randomNum)" +
            "\nYour score is \(score)\n" +
            "Extra points : \(extra)", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: {_ in self.startNewRound()} )
        
        alertCtrler.addAction(alertAction)
        present(alertCtrler, animated: true)
    }
    
    func startNewRound()
    {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:
        CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
        
        
        randomNum = Int.random(in: 1...100);
        roundCounter+=1;
        
        
        updatelabels()
    }
    
    func updatelabels()
    {
        sliderGuess = lroundf(slider.value)
        randomGuess.text = String(randomNum)
        round.text = String(roundCounter);
        score.text = String(scoreVal)
    }
    
    func calcScore(target: Int, actual: Int)-> Int
    {
        let score = 100 - abs(target - actual)
        scoreVal += score + (score == 100 ? 100 : 0)
        
        if top_score_.integer(forKey: "top_score") < scoreVal
        {
            top_score_.set(scoreVal, forKey: "top_score")
            topScore.text = String(scoreVal)
        }
        
        return score
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print(top_score_)
//        top_score_.set(0, forKey: "top_score")
        topScore.text = String(top_score_.integer(forKey: "top_score"))
        
        let thumbNormal = UIImage(named: "SliderThumb-Normal")
        let thumbHighligted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbNormal, for: .normal)
        slider.setThumbImage(thumbHighligted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let leftTrack = UIImage(named: "SliderTrackLeft")
        let rightTrack = UIImage(named: "SliderTrackRight")
        
        let leftTrackResizable  = leftTrack?.resizableImage(withCapInsets: insets)
        let rightTrackResizable  = rightTrack?.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(leftTrackResizable, for: .normal)
        slider.setMaximumTrackImage(rightTrackResizable, for: .normal)
        
        startNewRound()
    }
    
    @IBAction func onMoveSlider(_ slider: UISlider) {
        
        sliderGuess = lroundf(slider.value)
    }
    
    @IBAction func startOver(_ sender: Any) {
        
        slider.value = 1
        roundCounter=0;
        scoreVal = 0;
        sliderGuess = 0;
        
        startNewRound()
    }
    
    
}

