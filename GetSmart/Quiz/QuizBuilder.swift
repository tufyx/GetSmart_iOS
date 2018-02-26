//
//  QuizBuilder.swift
//  GetSmart
//
//  Created by Tufyx on 25/02/2018.
//  Copyright © 2018 Vlad Tufis. All rights reserved.
//

import Foundation

protocol QuizBuilderProtocol {
    
    var quiz: [Question] { get }
    
}

class QuizBuilder: QuizBuilderProtocol {
    
    let difficulty: Difficulty
    
    let questionSet: [Country]
    
    var quiz: [Question] {
        let countries = randomCountries()
        
        let questions = countries.map { (country) -> Question in
            Question(
                country: country,
                answers: selectAnswersFor(country: country),
                difficulty: difficulty
            )
        }
        
        return questions
    }
    
    init(difficulty: Difficulty, set: [Country]) {
        self.difficulty = difficulty
        self.questionSet = set
    }
    
    private func randomCountries() -> [Country] {
        var selectedCountries: [Country] = []
        let count = 5 + (Int(arc4random()) % questionSet.count/2)
        var c = questionSet.shuffled()
        var k: Int = 0
        while k < count {
            selectedCountries.append(c.popLast()!)
            k += 1
        }
        
        return selectedCountries
    }
    
    private func selectAnswersFor(country: Country) -> [String] {
        if difficulty.level == .easy {
            return easyAnswersFor(country: country)
        }
        
        if difficulty.level == .medium {
            return mediumAnswersFor(country: country)
        }
        
        if difficulty.level == .hard {
            return hardAnswersFor(country: country)
        }
        
        return []
    }
    
    func easyAnswersFor(country: Country) -> [String] {
        return getOptionsFor(
            country: country,
            from: questionSet.neighboursOf(country: country).capitals,
            or: questionSet.inSameRegionAs(country: country).capitals
        )
    }
    
    func mediumAnswersFor(country: Country) -> [String] {
        return getOptionsFor(
            country: country,
            from: questionSet.neighboursOf(country: country).capitals,
            or: questionSet.inSameRegionAs(country: country).capitals
        )
    }
    
    func hardAnswersFor(country: Country) -> [String] {
        return getOptionsFor(
            country: country,
            from: questionSet.capitals,
            or: questionSet.capitals
        )
    }
    
    func getOptionsFor(country: Country, from source: [String], or backup: [String]) -> [String] {
        
        if source.count == 0 && backup.count == 0 {
            return []
        }
        
        var c = source.shuffled()
        var o: [String] = [country.capital]
        var k: Int = 0
        while o.count < difficulty.numberOfQuestions {
            k += 1
            if c.count == 0 {
                break
            }
            
            var capital = c.removeFirst()
            while capital == country.name {
                capital = c.removeFirst()
            }
            o.append(capital)
        }
        
        if o.count == difficulty.numberOfQuestions {
            return o.shuffled()
        }
        
        c = backup.shuffled()
        while o.count < difficulty.numberOfQuestions {
            k += 1
            var capital = c.removeFirst()
            while capital == country.name || o.contains(capital) {
                capital = c.removeFirst()
            }
            o.append(capital)
        }
        return o.shuffled()
    }
    
}
