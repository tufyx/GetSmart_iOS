//
//  CDContinent.swift
//  GetSmart
//
//  Created by Tufyx on 09/12/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import CoreData

class CDContinent: NSManagedObject {
    
    @NSManaged var name: String
    
    var countries: [CDCountry]? {
        guard let countries = self.mutableSetValue(forKey: "countries").allObjects as? [CDCountry] else {
            return nil
        }
        
        return countries.sorted(by: { (c1, c2) -> Bool in
            c1.name < c2.name
        })
    }
    
    static let all: NSFetchRequest<CDContinent> = NSFetchRequest<CDContinent>(entityName: "CDContinent")
    
    static func with(name: String) -> NSFetchRequest<CDContinent> {
        let request = NSFetchRequest<CDContinent>(entityName: "CDContinent")
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1
        return request
    }

}
