//
//  MajorFlat.swift
//  tryagain
//
//  Created by Aasiya Memon on 5/20/23.
//

import UIKit

final class MajorFlat: KeyQuizViewController {
    override var keys: [String] {
        ["C Major","F Major","B♭ Major","E♭ Major","A♭ Major","D♭ Major","G♭ Major","C♭ Major"]
    }
    override var finishRule: KeyQuizEngine.FinishRule { .corrects(12) }
    // override var segueIdentifier: String { "transition3" }
}
