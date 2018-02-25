//
//  AnswerCell.swift
//  GetSmart
//
//  Created by Vlad Tufis on 06/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

protocol AnswerCellDelegate: class {

    func didSelect(answer: String)

}

class AnswerCell: UITableViewCell, Reusable {

    weak var delegate: AnswerCellDelegate?

    @IBOutlet weak var answerLabel: UILabel!

    var answer: String? {
        didSet {
            answerLabel.text = answer
            contentView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(didTapCell)
                )
            )
        }
    }

    @objc func didTapCell() {
        if let a = answer {
            delegate?.didSelect(answer: a)
        }
    }

}
