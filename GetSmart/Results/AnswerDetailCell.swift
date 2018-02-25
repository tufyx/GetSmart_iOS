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

    @IBOutlet weak var countryFlag: UIImageView!
    
    @IBOutlet weak var countryLabel: UILabel!

    @IBOutlet weak var answerLabel: UILabel!

    var viewData: ViewData? {
        didSet {
            if let vd = viewData {
                update(viewData: vd)
            }
        }
    }
    
    func update(viewData: ViewData) {
        countryLabel.text = viewData.country
        answerLabel.text = NSLocalizedString(
            "You said \(viewData.providedAnswer)",
            comment: "You said [CAPITAL]"
        )
        countryLabel.textColor = .black
        answerLabel.textColor = .black
        countryFlag.image = UIImage(named: viewData.flag)
        countryFlag.contentMode = .scaleAspectFit
        backgroundColor = UIColor.green.withAlphaComponent(0.1)
    }

    struct ViewData {

        let country: String
        let flag: String
        let providedAnswer: String
        let correctAnswer: String
        let valid: Bool

        init(answer: Answer) {
            flag = answer.country.code
            country = answer.country.name
            providedAnswer = answer.capital
            correctAnswer = answer.country.capital
            valid = answer.isValid
        }
    }

}
