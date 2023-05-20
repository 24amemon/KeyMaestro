//
//  MajFlat.swift
//  tryagain
//
//  Created by Aasiya Memon on 5/20/23.
//

import UIKit

class MajFlat: UIViewController {
    
    @IBOutlet var cButton: UIButton!
    @IBOutlet var gButton: UIButton!
    @IBOutlet var dButton: UIButton!
    @IBOutlet var aButton: UIButton!
    @IBOutlet var eButton: UIButton!
    @IBOutlet var bButton: UIButton!
    @IBOutlet var fSharpButton: UIButton!
    @IBOutlet var cSharpButton: UIButton!
    
    @IBOutlet var circleOfFifths: UIImageView!
    @IBOutlet var prompter: UILabel!
    @IBOutlet var infoButton: UIButton!
    @IBOutlet var correct: UILabel!
    @IBOutlet var rightAnswer: UIImageView!
    @IBOutlet var wrongAnswer: UIImageView!
    
    var commercialPopUp: PopUp!
    var questionsComplete = 0
    var wrongAnswers = 0
    var total = 0
    var endScore = ""
    
    @IBAction func PopButtonTapped(_ sender: Any) {
        self.commercialPopUp = PopUp(frame: self.view.frame)
        self.commercialPopUp.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.view.addSubview(commercialPopUp)
    }
    
    @objc func closeButtonTapped(){
        self.commercialPopUp.removeFromSuperview()
    }
    
    @IBAction func keyChosen(_ sender: UIButton) {
        if(randomInt == sender.tag){
            questionsComplete = questionsComplete + 1
            if(questionsComplete < 11){
                rightAnswer.blink()
            }
            rightAnswer.tintColor = UIColor.purple
            wrongAnswer.tintColor = UIColor.lightGray
            if(questionsComplete < 11) { newPrompt() }
            print(randomInt, sender.tag)
            updateProgress()
        } else{
            wrongAnswers = wrongAnswers + 1
            updateProgress()
            wrongAnswer.blink()
            wrongAnswer.tintColor = UIColor.red
            rightAnswer.tintColor = UIColor.lightGray

        }
        if(questionsComplete > 11){
            endScore = "Overall: " + String(questionsComplete) + "/" + String(total)
            infoButton.isHidden = true
            performSegue(withIdentifier: "transition3", sender: nil)
        }
        
    }
    
    var keys = ["C Major", "F Major", "B♭ Major", "E♭ Major", "A♭ Major", "D♭ Major", "G♭ Major", "C♭ Major"]
    
    let pi = Double.pi
    
    var randomInt = Int.random(in: 0..<8)
    
    var currentKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        circleButtons()
        
        infoButton.isHidden = false
        
        currentKey = keys[randomInt]
        
        prompter.text = currentKey
        
        circleOfFifths.image = UIImage(named:"conductor.png")
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
        randomInt = Int.random(in: 0..<8)
        
        prompter.text = keys[randomInt]
        prompter.blinkPrompt()
    }
    
    func updateProgress(){
        correct.text = "Score: " +  String(questionsComplete)
        let progressCirc = CAShapeLayer()
        
        total = wrongAnswers + questionsComplete
        
        
        let start = 0 - pi/2
        
        // let initialCirc = UIBezierPath(arcCenter: CGPoint(x: 196, y: 248), radius: 105, startAngle: start, endAngle: start + pi*(questionsComplete-1)/6, clockwise: true)

        //let circPath = UIBezierPath(arcCenter: CGPoint(x: circleOfFifths.frame.midX, y:  circleOfFifths.frame.midY), radius: 105, startAngle: start, endAngle: start + pi*Double(questionsComplete)/6, clockwise: true)
        
        //circleOfFifths.frame.maxY
        
        let circPath = UIBezierPath(arcCenter: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2-12-92), radius: 98, startAngle: start, endAngle: start + pi*Double(questionsComplete)/6, clockwise: true)
        
        progressCirc.path = circPath.cgPath
        progressCirc.strokeColor = UIColor.purple.cgColor
        progressCirc.fillColor = UIColor.clear.cgColor
        progressCirc.lineWidth = 5
        // progressCirc.strokeEnd = start + pi*questionsComplete/6
        
        view.layer.addSublayer(progressCirc)
        
        // let basicAnim = CABasicAnimation(keyPath: "strokeEnd")
        // basicAnim.toValue = start + pi*questionsComplete/6
        // basicAnim.duration = 2
        // basicAnim.fillMode = CAMediaTimingFillMode.forwards
        // basicAnim.isRemovedOnCompletion = false
        // progressCirc.add(basicAnim, forKey: "animation")
        
        

    }


}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

