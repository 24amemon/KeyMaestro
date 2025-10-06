//
//  KeyQuizViewController.swift
//  tryagain
//
//  Created by Aasiya Memon on 3/20/23.
//


import UIKit

class KeyQuizViewController: UIViewController {
    @IBOutlet var noteButtons: [UIButton]!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var wheelImage: UIImageView!
    @IBOutlet weak var prompter: UILabel!

    // Per-screen config (subclasses override)
    var keys: [String] { [] }
    var finishRule: KeyQuizEngine.FinishRule { .attempts(10) }
    var segueIdentifier: String { "transition" }
    var wheelImageName: String { "conductor.png" }

    // State / drawing
    private lazy var engine = KeyQuizEngine(keys: keys, finishRule: finishRule)
    private let progressLayer = CAShapeLayer()
    private let ringOffset: CGFloat = 6

    // PopUp
    var commercialPopUp: PopUp!

    override func viewDidLoad() {
        super.viewDidLoad()
        Sound.shared.preloadSFX(named: "right.wav")
        Sound.shared.preloadSFX(named: "wrong.wav")
        Sound.shared.preloadSFX(named: "select.wav")

        prompter.text = engine.promptText
        wheelImage.image = UIImage(named: wheelImageName)
        rightImage.tintColor = .lightGray
        wrongImage.tintColor = .lightGray

        // progress ring
        progressLayer.strokeColor = Theme.accent.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 5
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        view.layer.insertSublayer(progressLayer, below: wheelImage.layer)

        infoButton.isHidden = false
        updateScoreLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Sound.shared.stopMusic()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for b in noteButtons { b.makeCircular() }
        wheelImage.makeCircular()

        // Convert the image’s center into the root view’s coordinates
        let centerInView = wheelImage.superview?.convert(wheelImage.center, to: view) ?? wheelImage.center
        let base = min(wheelImage.bounds.width, wheelImage.bounds.height) / 2
        let radius = base + ringOffset
        let start: CGFloat = -.pi/2
        let path = UIBezierPath(
            arcCenter: centerInView,
            radius: radius,
            startAngle: start,
            endAngle: start + 2 * .pi,
            clockwise: true
        )

        progressLayer.path = path.cgPath
        progressLayer.frame = view.bounds

        progressLayer.strokeEnd = engine.progressFraction
    }

    // MARK: Actions (reuse on every scene)
    @IBAction func keyChosen(_ sender: UIButton) {
            guard let tapped = noteButtons.firstIndex(of: sender) else { return }

            if engine.registerTap(index: tapped) {
                rightImage.pulse()
                Sound.shared.playSFX("right.wav", volume: 0.5)
                rightImage.tintColor = Theme.accent
                wrongImage.tintColor = .lightGray
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                if !engine.isFinished {
                    engine.nextPrompt()
                    prompter.setTextWithSlide(engine.promptText)
                }
            } else {
                wrongImage.pulse()
                Sound.shared.playSFX("wrong.wav", volume: 0.5)
                wrongImage.tintColor = .red
                rightImage.tintColor = .lightGray
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }

            updateScoreLabel()
            animateProgress()

            if engine.isFinished {
                infoButton.isHidden = true
                goToDone(score: engine.score,
                         total: engine.totalAnswered,      // attempts used
                         target: engine.displayTarget)     // e.g., 12
            }
        }
    @IBAction func PopButtonTapped(_ sender: Any) {
        commercialPopUp = PopUp(frame: view.frame)
        Sound.shared.playSFX("select.wav", volume: 0.3)
        commercialPopUp.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(commercialPopUp)
    }

    @objc private func closeButtonTapped() {
        Sound.shared.playSFX("select.wav", volume: 0.3)
        commercialPopUp.removeFromSuperview()
    }

    private func updateScoreLabel() { correctLabel.text = "Score: \(engine.score)" }

    private func animateProgress() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.35)
        progressLayer.strokeEnd = engine.progressFraction
        CATransaction.commit()
    }
}

enum CompletionTransition {
    case push, present
}

extension KeyQuizViewController {
    func goToDone(score: Int, total: Int, target: Int) {
        let sb = storyboard ?? UIStoryboard(name: "Main", bundle: nil)
        guard let done = sb.instantiateViewController(withIdentifier: "DoneVC") as? DoneViewController else { return }
        done.score = score                // correct answers
        done.attemptsUsed = total         // correct + wrong
        done.target = target              // e.g., 12 for .corrects(12)

        if let nav = navigationController {
            nav.pushViewController(done, animated: true)
        } else {
            done.modalPresentationStyle = .fullScreen
            present(done, animated: true)
        }
    }
}
