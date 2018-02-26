//
//  DifficultyLevelCell.swift
//  GetSmart
//
//  Created by Tufyx on 26/02/2018.
//  Copyright © 2018 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

protocol DifficultyLevelTapProtocol {
    
    func didTapLevel(difficulty: Difficulty)
    
}

class DifficultyLevelCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var levelTitle: UILabel!
    
    @IBOutlet weak var levelDescription: UILabel!
    
    var delegate: DifficultyLevelTapProtocol?
    
    var difficulty: Difficulty? {
        didSet {
            guard let difficulty = difficulty else {
                levelTitle.text = NSLocalizedString("N/A", comment: "N/A")
                levelDescription.text = NSLocalizedString("N/A", comment: "N/A")
                return
            }
            
            contentView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(didTapCell)
                )
            )
            
            if difficulty.level == Difficulty.Level.easy {
                levelTitle.text = NSLocalizedString("Easy", comment: "Easy")
                levelDescription.text = NSLocalizedString("Easy difficulty - lorem ipsum dolor sit amet", comment: "Easy description")
                return
            }
            
            if difficulty.level == Difficulty.Level.medium {
                levelTitle.text = NSLocalizedString("Medium", comment: "Medium")
                levelDescription.text = NSLocalizedString("Medium difficulty - lorem ipsum dolor sit amet", comment: "Medium description")
                return
            }
            
            if difficulty.level == Difficulty.Level.hard {
                levelTitle.text = NSLocalizedString("Hard", comment: "Hard")
                levelDescription.text = NSLocalizedString("Hard difficulty - lorem ipsum dolor sit amet", comment: "Hard description")
                return
            }
            
        }
    }
    
    @objc func didTapCell() {
        guard let d = difficulty else {
            return
        }
        delegate?.didTapLevel(difficulty: d)
    }
    
}
