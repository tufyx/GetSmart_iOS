//
//  Reusable.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {

    final func loadViewControllerOfType<T: UIViewController>(type: T.Type) -> T where T: Reusable {
        guard let vc = self.instantiateViewController(withIdentifier: type.reuseIdentifier) as? T else {
            fatalError(
                "ViewController ID is expected to be \(type.reuseIdentifier)!!! " +
                "Check that you have set the correct property in the storyboard!"
            )
        }
        return vc
    }

}

extension UITableView {

    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }

}
