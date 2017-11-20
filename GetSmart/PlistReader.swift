//
//  PlistReader.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation

class PlistReader {

    var dictionary: [String: Any]?

    init(filename: String) {
        if let path = Bundle.main.path(forResource: filename, ofType: "plist") {

            ////If your plist contain root as Dictionary
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                self.dictionary = dic
            }
        }
    }

    
}
