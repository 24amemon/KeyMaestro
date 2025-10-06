//
//  KeyQuizEngine.swift
//  tryagain
//
//  Created by Aasiya Memon on 10/6/25.
//


import Foundation

struct KeyQuizEngine {
    let keys: [String]
    let maxQuestions: Int

    private(set) var score = 0
    private(set) var wrong = 0
    private(set) var currentIndex: Int
    private var lastIndex: Int?

    init(keys: [String], maxQuestions: Int = 10) {
        self.keys = keys
        self.maxQuestions = maxQuestions
        self.currentIndex = Int.random(in: 0..<keys.count)
        self.lastIndex = nil
    }

    var totalAnswered: Int { score + wrong }
    var promptText: String { keys[currentIndex] }
    var isFinished: Bool { totalAnswered >= maxQuestions }

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
