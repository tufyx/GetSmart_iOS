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

    var dataSource: [NSManagedObject] = []
    
    var coreDataStore: CoreDataStore = CoreDataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        let request = NSFetchRequest<CDContinent>(entityName: "CDContinent")
        do {
            dataSource = try coreDataStore.managedObjectContext.fetch(request)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContinentCell = tableView.dequeueReusableCell(for: indexPath)
        let item = dataSource[indexPath.row]
        let name = item.value(forKey: "name") as! String
        cell.delegate = self
        cell.viewData = ContinentCell.ViewData(name: name)
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
