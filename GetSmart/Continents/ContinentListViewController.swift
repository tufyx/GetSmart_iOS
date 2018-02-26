//
//  ContinentListViewController.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ContinentListViewController: UITableViewController, Reusable {

    var dataSource: [CDContinent] = []
    
    var coreDataStore: CoreDataStore = CoreDataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        do {
            dataSource = try coreDataStore.managedObjectContext.fetch(CDContinent.all)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContinentCell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewData = ContinentCell.ViewData(continent: dataSource[indexPath.row])
        cell.delegate = self
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

    func didTapCellFor(continent: CDContinent) {
        
        if continent.countries?.count == 0 {
            let alert = UIAlertController(
                title: NSLocalizedString("Oooooops!", comment: "Error title for continent selection"),
                message: NSLocalizedString("It seems like we don't have any questions in this set! Please try again later!", comment: "Error message displayed when not enough questions are available for a selected set"), preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Ok"), style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let vc = storyboard!.loadViewControllerOfType(type: SelectDifficultyList.self)
        vc.continent = continent
        navigationController?.pushViewController(vc, animated: true)
    }

}
