//
//  ResultsViewController.swift
//  GetSmart
//
//  Created by Vlad Tufis on 06/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

protocol ResultsDelegate: class {

    func didTapRestart()

}

class ResultsViewController: UIViewController, Reusable {

    var answers: [Answer] = []

    weak var delegate: ResultsDelegate?

    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var restartButton: UIButton!

    @IBOutlet weak var resultsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let correct = answers.filter { (answer) -> Bool in
            answer.isValid
        }

        resultLabel.text = "\(correct.count)/\(answers.count)"

        restartButton.addTarget(
            self,
            action: #selector(didTapRestart),
            for: .touchUpInside
        )

        resultsButton.addTarget(
            self,
            action: #selector(didTapDetails),
            for: .touchUpInside
        )

    }

    @objc func didTapRestart() {
        delegate?.didTapRestart()
        dismiss(animated: true, completion: nil)
    }

    @objc func didTapDetails() {
        if let vc = storyboard?.loadViewControllerOfType(type: ResultsDetailViewController.self) {
            vc.answers = answers
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
