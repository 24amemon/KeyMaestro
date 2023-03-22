//
//  ViewController.swift
//  tryagain
//
//  Created by Aasiya Memon on 3/20/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cButton: UIButton!
    @IBOutlet var gButton: UIButton!
    @IBOutlet var dButton: UIButton!
    @IBOutlet var aButton: UIButton!
    @IBOutlet var eButton: UIButton!
    @IBOutlet var bButton: UIButton!
    @IBOutlet var fSharpButton: UIButton!
    @IBOutlet var cSharpButton: UIButton!
    
    
    @IBOutlet var wrongAnswer: UIImageView!
    
    @IBOutlet var rightAnswer: UIImageView!
    
    @IBAction func keyChosen(_ sender: UIButton) {
        
        wrongAnswer.tintColor = UIColor.gray
        rightAnswer.tintColor = UIColor.gray
        
        if(randomInt == sender.tag){
            print(randomInt, sender.tag)
            questionsComplete = questionsComplete + 1.0
            newPrompt()
            //rightAnswer.tintColor = UIColor.black
            //wrongAnswer.tintColor = UIColor.gray
            updateProgress()
        }
        if(randomInt != sender.tag){
            print(randomInt, sender.tag)
            //rightAnswer.tintColor = UIColor.gray
            //wrongAnswer.tintColor = UIColor.black
        }
        if(questionsComplete > 11){
            updateProgress()
            prompter.text = "DONE!!!"
        }
    }
    
    
    @IBOutlet var circleOfFifths: UIImageView!
    
    @IBOutlet var prompter: UILabel!
    
    var keys = ["C Major", "G Major", "D Major", "A Major", "E Major", "B Major", "F# Major", "C# Major"]
    
    var questionsComplete = 0.0
    
    let pi = Double.pi
    
    var randomInt = Int.random(in: 1..<8)
    
    var currentKey = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        circleButtons()
        
        circleOfFifths.tintColor = UIColor.purple
        
        currentKey = keys[randomInt]
        
        prompter.text = currentKey
    }
    
    func circleButtons(){
        cButton.layer.cornerRadius = 0.5 * cButton.bounds.size.width
        cButton.clipsToBounds = true
        
        gButton.layer.cornerRadius = 0.5 * gButton.bounds.size.width
        gButton.clipsToBounds = true
        
        dButton.layer.cornerRadius = 0.5 * dButton.bounds.size.width
        dButton.clipsToBounds = true
        
        aButton.layer.cornerRadius = 0.5 * aButton.bounds.size.width
        aButton.clipsToBounds = true
        
        eButton.layer.cornerRadius = 0.5 * eButton.bounds.size.width
        eButton.clipsToBounds = true
        
        bButton.layer.cornerRadius = 0.5 * bButton.bounds.size.width
        bButton.clipsToBounds = true
        
        fSharpButton.layer.cornerRadius = 0.5 * fSharpButton.bounds.size.width
        fSharpButton.clipsToBounds = true
        
        cSharpButton.layer.cornerRadius = 0.5 * cSharpButton.bounds.size.width
        cSharpButton.clipsToBounds = true
        
        circleOfFifths.layer.cornerRadius = 0.5 * circleOfFifths.bounds.size.width
        circleOfFifths.clipsToBounds = true
    }
    
    func newPrompt(){
        randomInt = Int.random(in: 1..<8)
        
        prompter.text = keys[randomInt]
    }
    
    func updateProgress(){
        
        let progressCirc = CAShapeLayer()
        
        let start = 0 - pi/2
        
        let circPath = UIBezierPath(arcCenter: CGPoint(x: 196, y: 248), radius: 105, startAngle: start, endAngle: start + pi*questionsComplete/6, clockwise: true)
        
        progressCirc.path = circPath.cgPath
        
        progressCirc.strokeColor = UIColor.purple.cgColor
        
        progressCirc.fillColor = UIColor.clear.cgColor
        
        progressCirc.lineWidth = 5
        
        view.layer.addSublayer(progressCirc)
    }


}

