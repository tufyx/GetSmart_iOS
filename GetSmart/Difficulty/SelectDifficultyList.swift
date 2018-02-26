//
//  SelectDifficultyList.swift
//  GetSmart
//
//  Created by Tufyx on 26/02/2018.
//  Copyright © 2018 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

class SelectDifficultyList: UIViewController, Reusable {
    
    @IBOutlet weak var tableView: UITableView!
    
    var continent: CDContinent?
    
    var defaults: GetSmartUserDefaultsProtocol?
    
    var dataSource: [Difficulty] = [
        Difficulty.Easy,
        Difficulty.Medium,
        Difficulty.Hard
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        defaults = GetSmartUserDefaults()
    }
}

extension SelectDifficultyList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let difficulty = dataSource[indexPath.row]
        let cell: DifficultyLevelCell = tableView.dequeueReusableCell(for: indexPath)
        cell.difficulty = difficulty
        cell.delegate = self
        return cell
    }
    
}

extension SelectDifficultyList: DifficultyLevelTapProtocol {
    
    func didTapLevel(difficulty: Difficulty) {
        defaults?.difficulty = difficulty
        let vc = storyboard!.loadViewControllerOfType(type: QuizViewController.self)
        vc.continent = continent
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
