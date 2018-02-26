//
//  GetSmartUserDefaults.swift
//  GetSmart
//
//  Created by Tufyx on 24/02/2018.
//  Copyright © 2018 Vlad Tufis. All rights reserved.
//

import Foundation

protocol GetSmartUserDefaultsProtocol {
    
    var initialized: Bool { get set }
    
    var difficulty: Difficulty { get set }
    
}

class GetSmartUserDefaults: GetSmartUserDefaultsProtocol {
    
    let defaults: UserDefaults
    
    var initialized: Bool {
        set {
            defaults.setValue(newValue, forKeyPath: "app_initialized")
        }
        get {
            return defaults.bool(forKey: "app_initialized")
        }
    }
    
    var difficulty: Difficulty {
        set {
            defaults.setValue(newValue.serialized, forKeyPath: "difficulty")
        }
        get {
            guard let d = defaults.dictionary(forKey: "difficulty") else {
                return Difficulty.Easy
            }
            
            return Difficulty(data: d)
        }
    }
    
    init() {
        defaults = UserDefaults.standard
    }    
    
}
