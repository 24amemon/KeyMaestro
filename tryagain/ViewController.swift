//
//  ViewController.swift
//  tryagain
//
//  Created by Aasiya Memon on 3/20/23.
//

import UIKit

class MajorSharp: UIViewController {

    // MARK: - IBOutlets
    // Connect *all eight* buttons here in this order to match `keys`:
    // C, G, D, A, E, B, F#, C#  (or adjust keys to your order)
    @IBOutlet var noteButtons: [UIButton]!

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongAnswer: UIImageView!
    @IBOutlet weak var circleOfFifths: UIImageView!
    @IBOutlet weak var rightAnswer: UIImageView!
    @IBOutlet weak var prompter: UILabel!

    // MARK: - PopUp
    var commercialPopUp: PopUp!

    // MARK: - Game State
    private let keys = ["C Major","G Major","D Major","A Major","E Major","B Major","F# Major","C# Major"]
    private let maxQuestions = 10
    private var score = 0                 // correct answers
    private var wrongAnswers = 0          // wrong answers
    private var currentIndex = Int.random(in: 0..<8)
    private var lastIndex: Int?

    // MARK: - UI / Drawing
    private let theme = UIColor(red: 119/255, green: 59/255, blue: 85/255, alpha: 1)
    private let progressLayer = CAShapeLayer()
    private let ringLineWidth: CGFloat = 5

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        infoButton.isHidden = false

        // initial state
        prompter.text = keys[currentIndex]
        circleOfFifths.image = UIImage(named:"conductor.png")
        rightAnswer.tintColor = theme
        wrongAnswer.tintColor = .lightGray

        // progress ring layer once
        progressLayer.strokeColor = theme.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = ringLineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        view.layer.addSublayer(progressLayer)

        updateScoreLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Make everything circular after layout
        for b in noteButtons { b.makeCircular() }
        circleOfFifths.makeCircular()

        // (Re)compute ring path around the image view’s center
        let center = CGPoint(x: circleOfFifths.frame.midX, y: circleOfFifths.frame.midY)
        let radius = min(circleOfFifths.bounds.width, circleOfFifths.bounds.height)/2 + 8
        let start = -CGFloat.pi/2
        let end = start + 2*CGFloat.pi
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        progressLayer.path = path.cgPath
        // Keep current progress
        progressLayer.strokeEnd = CGFloat(score) / CGFloat(maxQuestions)
    }

    // MARK: - IBActions
    @IBAction func PopButtonTapped(_ sender: Any) {
        commercialPopUp = PopUp(frame: view.frame)
        commercialPopUp.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(commercialPopUp)
    }

    @objc private func closeButtonTapped() {
        commercialPopUp.removeFromSuperview()
    }

    @IBAction func keyChosen(_ sender: UIButton) {
        // Get the tapped index using the outlet collection order
        guard let tappedIndex = noteButtons.firstIndex(of: sender) else { return }

        if tappedIndex == currentIndex {
            score += 1
            rightAnswer.blink(duration: 0.5)
            rightAnswer.tintColor = theme
            wrongAnswer.tintColor = .lightGray
            if totalAnswered < maxQuestions { newPrompt() }
        } else {
            wrongAnswers += 1
            wrongAnswer.blink(duration: 0.5)
            wrongAnswer.tintColor = .red
            rightAnswer.tintColor = .lightGray
        }

        updateScoreLabel()
        updateProgressRing()

        if totalAnswered >= maxQuestions {
            infoButton.isHidden = true
            performSegue(withIdentifier: "transition", sender: nil)
        }
    }

    // MARK: - Helpers
    private var totalAnswered: Int { score + wrongAnswers }

    private func newPrompt() {
        // Avoid immediate repeats for a nicer flow
        repeat { currentIndex = Int.random(in: 0..<keys.count) }
        while currentIndex == lastIndex
        lastIndex = currentIndex

        prompter.text = keys[currentIndex]
        prompter.blinkPrompt()
    }

    private func updateScoreLabel() {
        correctLabel.text = "Score: \(score)"
    }

    private func updateProgressRing() {
        // Animate strokeEnd towards new fraction of maxQuestions
        let progress = CGFloat(score) / CGFloat(maxQuestions)
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.35)
        progressLayer.strokeEnd = progress
        CATransaction.commit()
    }
}
