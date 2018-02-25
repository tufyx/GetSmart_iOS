//
//  Country.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import CoreData

class Country {

    let code: String
    let name: String
    let capital: String
    let flag: String
    let borders: [String]
    let subregion: String

    init(data: [String: Any]) {
        self.code = data["alpha3Code"] as! String
        self.name = data["name"] as! String
        self.capital = data["capital"] as! String
        self.flag = data["flag"] as! String
        self.borders = data["borders"] as! [String]
        self.subregion = data["subregion"] as! String
    }
    
    init(country: CDCountry) {
        self.code = country.code
        self.name = country.name
        self.capital = country.capital
        self.flag = country.flag
        if let borders = country.neighbours {
            self.borders = borders.map({ (cdc) -> String in
                cdc.code
            })
        } else {
            self.borders = []
        }
        self.subregion = country.region.name
    }
    
    static let Unknown: Country = Country(data:
        ["alpha3Code": "-",
         "name": "-",
         "capital": "-",
         "flag": "-",
         "borders": [],
         "subregion": "-"]
    )

}
