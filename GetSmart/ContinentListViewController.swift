//
//  ContinentListViewController.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

class ContinentListViewController: UITableViewController, Reusable {

    var dataSource: [String] = [
        "Europe",
        "North America",
        "South America",
        "Asia",
        "Africa",
        "Australia & Oceania"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContinentCell = tableView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        cell.viewData = ContinentCell.ViewData(name: dataSource[indexPath.row])
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

}

extension ContinentListViewController: CellDelegate {

    func didTapCell(continent: String) {
        let vc = storyboard!.loadViewControllerOfType(type: QuizViewController.self)
        navigationController?.pushViewController(vc, animated: true)
    }

}
