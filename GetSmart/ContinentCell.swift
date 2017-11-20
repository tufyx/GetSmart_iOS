//
//  ContinentCell.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

protocol CellDelegate: class {

    func didTapCell(continent: String)

}

class ContinentCell: UITableViewCell, Reusable {

    weak var delegate: CellDelegate?

    @IBOutlet weak var name: UILabel!

    var viewData: ViewData? {
        didSet {
            name.text = viewData?.name

            contentView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(didTapCell))
            )
        }
    }

    @objc func didTapCell() {
        if let vd = viewData, let d = delegate {
            d.didTapCell(continent: vd.name)
        }

    }

    struct ViewData {

        let name: String

        init(name: String) {
            self.name = name
        }

    }

}
