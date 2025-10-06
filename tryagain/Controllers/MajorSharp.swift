//
//  MajorSharp.swift
//  tryagain
//
//  Created by Aasiya Memon on 3/13/23.
//

final class MajorSharp: KeyQuizViewController {
    override var keys: [String] {
        ["C Major","G Major","D Major","A Major","E Major","B Major","F# Major","C# Major"]
    }
    override var finishRule: KeyQuizEngine.FinishRule { .corrects(12) }
    // override var segueIdentifier: String { "transition" }
}
