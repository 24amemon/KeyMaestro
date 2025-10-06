//
//  UIView+Effects.swift
//  tryagain
//
//  Created by Aasiya Memon on 3/20/23.
//

import UIKit

extension UIView {
    func pulse(minAlpha: CGFloat = 0.35,
               scale: CGFloat = 1.06,
               duration: TimeInterval = 0.45) {
        layer.removeAllAnimations()
        alpha = 1
        transform = .identity

        UIView.animateKeyframes(withDuration: duration, delay: 0,
                                options: [.calculationModeCubic, .allowUserInteraction]) {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.45) {
                self.alpha = minAlpha
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.55) {
                self.alpha = 1
                self.transform = .identity
            }
        }
    }

    func stopPulse() {
        layer.removeAllAnimations()
        alpha = 1
        transform = .identity
    }
    
    func makeCircular() {
            layoutIfNeeded()
            let d = min(bounds.width, bounds.height)
            layer.cornerRadius = d / 2
            layer.masksToBounds = true
            if #available(iOS 13.0, *) { layer.cornerCurve = .continuous }
        }
}

extension UILabel {
    func setTextWithSlide(_ newText: String,
                          delay: TimeInterval = 0.08,
                          move: CGFloat = 6,
                          duration: TimeInterval = 0.22) {
        UIView.animate(withDuration: duration, delay: 0,
                       options: [.curveEaseIn, .allowUserInteraction]) {
            self.transform = CGAffineTransform(translationX: 0, y: move)
            self.alpha = 0.0
        } completion: { _ in
            self.text = newText
            self.transform = CGAffineTransform(translationX: 0, y: -move)
            UIView.animate(withDuration: duration, delay: delay,
                           usingSpringWithDamping: 0.88, initialSpringVelocity: 0,
                           options: [.curveEaseOut, .allowUserInteraction]) {
                self.transform = .identity
                self.alpha = 1.0
            }
        }
    }
}
