//
//  KeyQuizEngine.swift
//  tryagain
//
//  Created by Aasiya Memon on 10/6/25.
//


import Foundation

struct KeyQuizEngine {
    enum FinishRule {
        case attempts(Int) // finish after N attempts (correct + wrong)
        case corrects(Int) // finish after N correct answers
    }

    let keys: [String]
    let finishRule: FinishRule

    private(set) var score = 0 // correct
    private(set) var wrong = 0
    private(set) var currentIndex = Int.random(in: 0..<8)
    private var lastIndex: Int?

    init(keys: [String], finishRule: FinishRule = .attempts(10)) {
        self.keys = keys
        self.finishRule = finishRule
    }

    var totalAnswered: Int { score + wrong }

    var isFinished: Bool {
        switch finishRule {
        case .attempts(let n): return totalAnswered >= n
        case .corrects(let n): return score >= n
        }
    }

    // For UI
    var progressFraction: CGFloat {
        switch finishRule {
        case .attempts(let n): return CGFloat(totalAnswered) / CGFloat(max(n,1))
        case .corrects(let n): return CGFloat(score) / CGFloat(max(n,1))
        }
    }

    // Optional: what “total” means for display (“out of”)
    var displayTarget: Int {
        switch finishRule {
        case .attempts(let n): return n
        case .corrects(let n): return n
        }
    }

    var promptText: String { keys[currentIndex] }

    mutating func registerTap(index: Int) -> Bool {
        let ok = (index == currentIndex)
        if ok { score += 1 } else { wrong += 1 }
        return ok
    }

    mutating func nextPrompt() {
        repeat { currentIndex = Int.random(in: 0..<keys.count) } while currentIndex == lastIndex
        lastIndex = currentIndex
    }
}
