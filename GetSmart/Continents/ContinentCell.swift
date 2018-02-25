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

    func didTapCellFor(continent: CDContinent)

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
                    action: #selector(didTapCell)
                )
            )
        }
    }

    @objc func didTapCell() {
        if let vd = viewData, let d = delegate {
            d.didTapCellFor(continent: vd.continent)
        }

    }

    struct ViewData {

        let continent: CDContinent
        let name: String

        init(continent: CDContinent) {
            self.continent = continent
            self.name = continent.name
        }

    }

}
