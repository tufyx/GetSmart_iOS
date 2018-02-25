//
//  PlistReader.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation

class PlistReader {

    var dictionary: [String: [[String: Any]]]?

    init(filename: String) {
        if let path = Bundle.main.path(forResource: filename, ofType: "plist") {

            ////If your plist contain root as Dictionary
            guard let dict = NSDictionary(contentsOfFile: path) as? [String: [[String: Any]]] else {
                print("Plist reading failed > could not read dictionary from plist")
                return
            }
            self.dictionary = dict
        }
    }
    
}
