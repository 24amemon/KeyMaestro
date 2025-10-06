//
//  ViewController.swift
//  tryagain
//
//  Created by Aasiya Memon on 3/20/23.
//

final class MajorSharp: KeyQuizViewController {
    override var keys: [String] {
        ["C Major","G Major","D Major","A Major","E Major","B Major","F# Major","C# Major"]
    }
    override var segueIdentifier: String { "transition" }
}
