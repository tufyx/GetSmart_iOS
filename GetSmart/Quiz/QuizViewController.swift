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

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var progressBar: UIProgressView!

    @IBOutlet weak var labelQuestion: UILabel!

    @IBOutlet weak var flagImage: UIImageView!

    @IBOutlet weak var answerList: UITableView!

    @IBOutlet weak var giveUpButton: UIButton!

    var remainingQuestions: [Question] = []

    var answers: [Answer] = []

    var currentCountry: Country?

    var options: [String] = []
    
    var countries: [Country] = []
    
    var continent: CDContinent?
    
    var coreDataStore: CoreDataStore = CoreDataStore()
    
    var quizBuilder: QuizBuilderProtocol?
    
    var userDefaults: GetSmartUserDefaultsProtocol = GetSmartUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        giveUpButton.addTarget(
            self,
            action: #selector(didTapGiveUp),
            for: .touchUpInside
        )
        
        if let content = continent?.countries {
            countries = content.map({ (country) -> Country in
                Country(country: country)
            })
        }
        
        initialize()
    }

    func initialize() {
        giveUpButton.isHidden = false
        
        quizBuilder = QuizBuilder(difficulty: userDefaults.difficulty, set: countries)
        remainingQuestions = quizBuilder!.quiz

        answerList.dataSource = self
        answerList.delegate = self
        answerList.tableFooterView = UIView()
        answerList.isUserInteractionEnabled = true

        nextQuestion()
    }

    func nextQuestion() {
        let progress = Float(answers.count) / Float(answers.count + remainingQuestions.count)
        progressBar.setProgress(progress, animated: true)
        
        let question = remainingQuestions.removeFirst()
        currentCountry = question.country
        flagImage.image = UIImage(named: currentCountry!.code)
        options = question.answers

        labelQuestion.text = NSLocalizedString(
            "What is the capital of [COUNTRY]?",
            comment: "What is the capital of [COUNTRY]?"
            ).forCountry(country: currentCountry!.name)

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

        if remainingQuestions.count > 0 {
            nextQuestion()
            return
        }

        progressBar.setProgress(1.0, animated: true)
        giveUpButton.isHidden = true
        answerList.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (t) in
            self.activityIndicator.stopAnimating()
            self.displayResults()
            t.invalidate()
        })
    }
    
    func displayResults() {
        let vc = storyboard?.loadViewControllerOfType(type: ResultsViewController.self)
        vc?.answers = answers
        vc?.delegate = self
        vc?.modalTransitionStyle = .crossDissolve
        navigationController?.pushViewController(vc!, animated: true)
    }

}

extension QuizViewController: ResultsDelegate {

    func didTapRestart() {
        navigationController?.popToRootViewController(animated: false)
    }

}
