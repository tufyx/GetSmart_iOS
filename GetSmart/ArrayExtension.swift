//
//  ArrayExtension.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }

        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

extension Array where Element: Country {

    var capitals : [String] {
        return self.map({ (country) -> String in
            return country.capital
        })
    }

    var list : [String] {
        return self.map({ (country) -> String in
            return country.name
        })
    }
    
    func filterBy(code: String) -> Country {
        let filters = self.filter({ (c) -> Bool in
            c.code == code
        })
    
        guard let country = filters.first else {
            return Country.Unknown
        }
        
        return country
    }
    
    func neighboursOf(country: Country) -> [Country] {
        return country.borders.map { (neighbour) -> Country in
            self.filterBy(code: neighbour)
        }
    }
    
    func inSameRegionAs(country: Country) -> [Country] {
        return self.filter({ (c) -> Bool in
            c.subregion == country.subregion
        })
    }

}
