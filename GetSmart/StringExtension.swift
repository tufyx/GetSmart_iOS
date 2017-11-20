//
//  StringExtension.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation

extension String {

    func forCountry(country: String) -> String {
        return self.replacingOccurrences(of: "[COUNTRY]", with: country)
    }

}
