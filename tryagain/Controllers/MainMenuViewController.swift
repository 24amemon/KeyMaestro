//
//  MainMenuViewController.swift
//  tryagain
//
//  Created by Aasiya Memon on 3/31/23.
//


import UIKit

final class MainMenuViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Sound.shared.startMusic("menu jingle.wav", volume: 1)
        Sound.shared.preloadSFX(named: "select.wav")
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
            Sound.shared.playSFX("select.wav", volume: 0.3)
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Sound.shared.stopMusic()
    }
}
