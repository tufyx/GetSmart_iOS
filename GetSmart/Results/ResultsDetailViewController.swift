//
//  ResultsDetailViewController.swift
//  GetSmart
//
//  Created by Vlad Tufis on 06/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

class ResultsDetailViewController: UIViewController, Reusable {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var answers: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = NSLocalizedString("Details", comment: "Details")
        closeButton.addTarget(
            self,
            action: #selector(didTapClose),
            for: .touchUpInside
        )
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }

}

extension ResultsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        
        if answer.isValid {
            let validCell: AnswerDetailCell = tableView.dequeueReusableCell(for: indexPath)
            validCell.viewData = AnswerDetailCell.ViewData(answer: answers[indexPath.row])
            return validCell
        }
        
        let invalidCell: AnswerDetailWrongCell = tableView.dequeueReusableCell(for: indexPath)
        invalidCell.viewData = AnswerDetailWrongCell.ViewData(answer: answers[indexPath.row])
        return invalidCell
    }

}
