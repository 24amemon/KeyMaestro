//
//  UIView+Effects.swift
//  tryagain
//
//  Created by Aasiya Memon on 10/6/25.
//

import UIKit

extension UIView {
    func makeCircular() {
        layoutIfNeeded()
        layer.cornerRadius = min(bounds.width, bounds.height)/2
        clipsToBounds = true
    }

    func blink(duration: TimeInterval = 0.5) {
        alpha = 0
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveEaseInOut, .autoreverse],
                       animations: { self.alpha = 1 },
                       completion: { _ in self.alpha = 1 })
    }

    func blinkPrompt(duration: TimeInterval = 0.2) {
        alpha = 0
        UIView.animate(withDuration: duration, delay: 0,
                       options: [.curveEaseInOut],
                       animations: { self.alpha = 1 })
    }

    func stopBlink() {
        layer.removeAllAnimations()
        alpha = 1
    }
}
