//
//  AnswerDetailCell.swift
//  GetSmart
//
//  Created by Vlad Tufis on 06/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

class AnswerDetailCell: UITableViewCell, Reusable {

    @IBOutlet weak var countryLabel: UILabel!

    @IBOutlet weak var answerLabel: UILabel!

    var viewData: ViewData? {
        didSet {
            if let vd = viewData {
                countryLabel.text = vd.country
                answerLabel.text = NSLocalizedString("You said \(vd.providedAnswer)", comment: "You said [COUNTRY]")
                let color: UIColor = vd.valid ? UIColor.green : UIColor.red
                countryLabel.textColor = UIColor.black
                answerLabel.textColor = UIColor.black
                backgroundColor = color.withAlphaComponent(0.1)
            }

        }
    }

    struct ViewData {

        let country: String
        let providedAnswer: String
        let valid: Bool

        init(answer: Answer) {
            country = answer.country.name
            providedAnswer = answer.capital
            valid = answer.isValid
        }
    }

}
