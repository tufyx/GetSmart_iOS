//
//  Country.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation

class Country {

    let name: String
    let capital: String
    let flag: String

    init(data: [String: Any]) {
        self.name = data["name"] as! String
        self.capital = data["capital"] as! String
        self.flag = data["flag"] as! String
    }

}
