//
//  DifficultyLevel.swift
//  GetSmart
//
//  Created by Tufyx on 25/02/2018.
//  Copyright © 2018 Vlad Tufis. All rights reserved.
//

import Foundation

extension Difficulty: Equatable {
    
    static func ==(lhs: Difficulty, rhs: Difficulty) -> Bool {
        return
            lhs.level.rawValue == rhs.level.rawValue &&
            lhs.numberOfQuestions == rhs.numberOfQuestions &&
            lhs.timePerQuestion == rhs.timePerQuestion
    }

}

class Difficulty {
    
    enum Level: Int {
        case easy
        case medium
        case hard
    }
    
    var level: Level
    var timePerQuestion: TimeInterval
    var numberOfQuestions: Int
    
    init(level: Level, time: TimeInterval, questions: Int) {
        self.level = level
        self.timePerQuestion = time
        self.numberOfQuestions = questions
    }
    
    convenience init(data: [String: Any]) {
        let level = data["level"] as! Int
        let time = data["time"] as! TimeInterval
        let questions = data["questions"] as! Int
        self.init(level: Difficulty.Level(rawValue: level)!, time: time, questions: questions)
    }
    
    var serialized: [String: Any] {
        return ["level": level.rawValue, "time": timePerQuestion, "questions": numberOfQuestions]
    }
    
    static let Easy = Difficulty(level: .easy, time: .infinity, questions: 4)
    static let Medium = Difficulty(level: .medium, time: 10, questions: 6)
    static let Hard = Difficulty(level: .hard, time: 5, questions: 8)
    
}
