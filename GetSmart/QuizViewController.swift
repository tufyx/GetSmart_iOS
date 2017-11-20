//
//  QuizViewController.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import UIKit

struct Answer {

    let country: Country

    let capital: String

    init(country: Country, capital: String) {
        self.country = country
        self.capital = capital
    }

    var isValid: Bool {
        return country.capital == capital
    }
}

class QuizViewController: UIViewController, Reusable {

    @IBOutlet weak var labelProgress: UILabel!

    @IBOutlet weak var labelQuestion: UILabel!

    @IBOutlet weak var flagImage: UIImageView!

    @IBOutlet weak var answerList: UITableView!

    @IBOutlet weak var giveUpButton: UIButton!

    var remainingQuestions: [Country] = []

    var answers: [Answer] = []

    var capitals: [String] = []

    var currentCountry: Country?

    var options: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let content = PlistReader(filename: "Europe").dictionary {
            initialize(c: content)
        }

    }

    func getOptionsFrom(source: [String]) -> [String] {
        var c = source.shuffled()
        var o: [String] = [currentCountry!.capital]
        var k: Int = 0
        while k < 3 {
            k += 1
            var capital = c.removeFirst()
            while capital == currentCountry!.name {
                capital = c.removeFirst()
            }
            o.append(capital)
        }
        return o.shuffled()
    }

    func initialize(c: [String: Any]) {
        let c_arr = c["countries"] as! [[String: Any]]
        var countries: [Country] = c_arr.map({ (data) -> Country in
            Country(data: data)
        })

        giveUpButton.addTarget(
            self,
            action: #selector(didTapGiveUp),
            for: .touchUpInside
        )

        capitals = countries.capitals

        let count = 10 + (Int(arc4random()) % countries.count/2)
        countries = countries.shuffled()
        var k: Int = 0
        while k < count {
            remainingQuestions.append(countries.popLast()!)
            k += 1
        }

        answerList.dataSource = self
        answerList.delegate = self
        answerList.tableFooterView = UIView()

        nextQuestion()
    }

    func nextQuestion() {
        currentCountry = remainingQuestions.removeFirst()
        options = getOptionsFrom(source: capitals)

        labelQuestion.text = NSLocalizedString(
            "What is the capital of [COUNTRY]?",
            comment: "What is the capital of [COUNTRY]?"
            ).forCountry(country: currentCountry!.name)

        labelProgress.text = NSLocalizedString("\(remainingQuestions.count) remaining questions ", comment: "[X] remaining questions")

        answerList.reloadData()

    }

    @objc func didTapGiveUp() {
        navigationController?.popToRootViewController(animated: true)
    }

}

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AnswerCell = tableView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        cell.answer = options[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

extension QuizViewController: AnswerCellDelegate {

    func didSelect(answer: String) {
        answers.append(
            Answer(
                country: currentCountry!,
                capital: answer
            )
        )

        if remainingQuestions.count == 0 {
            let vc = storyboard?.loadViewControllerOfType(type: ResultsViewController.self)
            vc?.answers = answers
            vc?.delegate = self
            vc?.modalTransitionStyle = .crossDissolve
            navigationController?.pushViewController(vc!, animated: true)
            return
        }

        nextQuestion()
    }

}

extension QuizViewController: ResultsDelegate {

    func didTapRestart() {
        navigationController?.popToRootViewController(animated: false)
    }

}
