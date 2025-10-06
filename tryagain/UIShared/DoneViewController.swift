//
//  DoneViewController.swift
//  tryagain
//
//  Created by Aasiya Memon on 5/18/23.
//

import UIKit

final class DoneViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?

    var score: Int = 0
    var attemptsUsed: Int = 0
    var target: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel?.text = "Score: \(score)/\(target)"
        detailLabel?.text = "Attempts used: \(attemptsUsed)"
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


