//
//  KeyQuizViewController.swift
//  tryagain
//
//  Created by Aasiya Memon on 10/6/25.
//


import UIKit

class KeyQuizViewController: UIViewController {
    // Shared outlets (same wiring on every scene)
    @IBOutlet var noteButtons: [UIButton]!        // connect all 8 in order
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var wheelImage: UIImageView!
    @IBOutlet weak var prompter: UILabel!

    // Per-screen config (subclasses override)
    var keys: [String] { [] }
    var segueIdentifier: String { "transition" }  // subclasses can override (you used 2/3/4)
    var wheelImageName: String { "conductor.png" }
    var maxQuestions: Int { 10 }

    // State / drawing
    private lazy var engine = KeyQuizEngine(keys: keys, maxQuestions: maxQuestions)
    private let progressLayer = CAShapeLayer()

    // PopUp (since all scenes use it)
    var commercialPopUp: PopUp!

    override func viewDidLoad() {
        super.viewDidLoad()

        prompter.text = engine.promptText
        wheelImage.image = UIImage(named: wheelImageName)
        rightImage.tintColor = Theme.accent
        wrongImage.tintColor = .lightGray

        // progress ring
        progressLayer.strokeColor = Theme.accent.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 5
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        view.layer.addSublayer(progressLayer)

        infoButton.isHidden = false
        updateScoreLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for b in noteButtons { b.makeCircular() }
        wheelImage.makeCircular()

        let c = CGPoint(x: wheelImage.frame.midX, y: wheelImage.frame.midY)
        let r = min(wheelImage.bounds.width, wheelImage.bounds.height)/2 + 8
        let path = UIBezierPath(arcCenter: c, radius: r,
                                startAngle: -.pi/2, endAngle: 1.5 * .pi, clockwise: true)
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = CGFloat(engine.score) / CGFloat(engine.maxQuestions)
    }

    // MARK: Actions (reuse on every scene)
    @IBAction func keyChosen(_ sender: UIButton) {
        guard let tapped = noteButtons.firstIndex(of: sender) else { return } // outlet order, not tags

        if engine.registerTap(index: tapped) {
            rightImage.blink()
            rightImage.tintColor = Theme.accent
            wrongImage.tintColor = .lightGray
            if !engine.isFinished {
                engine.nextPrompt()
                prompter.text = engine.promptText
                prompter.blinkPrompt()
            }
        } else {
            wrongImage.blink()
            wrongImage.tintColor = .red
            rightImage.tintColor = .lightGray
        }

        updateScoreLabel()
        animateProgress()

        if engine.isFinished {
            infoButton.isHidden = true
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }

    @IBAction func PopButtonTapped(_ sender: Any) {
        commercialPopUp = PopUp(frame: view.frame)
        commercialPopUp.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(commercialPopUp)
    }

    @objc private func closeButtonTapped() { commercialPopUp.removeFromSuperview() }

    private func updateScoreLabel() { correctLabel.text = "Score: \(engine.score)" }

    private func animateProgress() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.35)
        progressLayer.strokeEnd = CGFloat(engine.score) / CGFloat(engine.maxQuestions)
        CATransaction.commit()
    }
}