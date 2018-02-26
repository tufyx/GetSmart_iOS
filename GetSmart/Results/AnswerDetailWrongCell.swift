//
//  AnswerDetailWrongCell.swift
//  GetSmart
//
//  Created by Tufyx on 25/02/2018.
//  Copyright © 2018 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

class AnswerDetailWrongCell: AnswerDetailCell {
    
    override func update(viewData: AnswerDetailCell.ViewData) {
        super.update(viewData: viewData)
        answerLabel.text = NSLocalizedString(
            "You said \(viewData.providedAnswer), but it is \(viewData.correctAnswer)",
            comment: "You said [CAPITAL], but it is [CAPITAL]"
        )
        backgroundColor = UIColor.red.withAlphaComponent(0.1)
    }
    
}
