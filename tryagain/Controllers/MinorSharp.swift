//
//  ViewController.swift
//  tryagain
//
//  Created by Aasiya Memon on 3/20/23.
//

import UIKit

final class MinorSharp: KeyQuizViewController {
    override var keys: [String] {
        ["a minor","e minor","b minor","f# minor","c# minor","g# minor","d# minor","a# minor"]
    }
    override var segueIdentifier: String { "transition2" }
}
