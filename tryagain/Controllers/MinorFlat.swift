//
//  MinorFlat.swift
//  tryagain
//
//  Created by Aasiya Memon on 5/20/23.
//

import UIKit

final class MinorFlat: KeyQuizViewController {
    override var keys: [String] {
        ["a minor","d minor","g minor","c minor","f minor","b♭ minor","e♭ minor","a♭ minor"]
    }
    override var finishRule: KeyQuizEngine.FinishRule { .corrects(12) }
    // override var segueIdentifier: String { "transition4" }
}
