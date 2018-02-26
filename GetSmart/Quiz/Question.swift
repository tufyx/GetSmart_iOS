//
//  Question.swift
//  GetSmart
//
//  Created by Tufyx on 25/02/2018.
//  Copyright © 2018 Vlad Tufis. All rights reserved.
//

import Foundation

class Question {
    
    var country: Country
    
    var answers: [String]
    
    var selectedAnswer: String?
    
    var difficulty: Difficulty
    
    var isCorrect: Bool {
        return country.capital == selectedAnswer
    }
    
    var isAnswered: Bool {
        return selectedAnswer != nil
    }
    
    init(country: Country, answers: [String], difficulty: Difficulty) {
        self.country = country
        self.answers = answers
        self.difficulty = difficulty
    }
    
    
    
}
