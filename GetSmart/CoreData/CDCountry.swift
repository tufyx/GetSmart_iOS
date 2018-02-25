//
//  CDCountry.swift
//  GetSmart
//
//  Created by Tufyx on 09/12/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import CoreData

class CDCountry: NSManagedObject {
    
    static let all: NSFetchRequest<CDCountry> = NSFetchRequest<CDCountry>(entityName: "CDCountry")
    
    static func with(code: String) -> NSFetchRequest<CDCountry> {
        let request = NSFetchRequest<CDCountry>(entityName: "CDCountry")
        request.predicate = NSPredicate(format: "code == %@", code)
        request.fetchLimit = 1
        return request
    }
    
    @NSManaged var name: String
    @NSManaged var capital: String
    @NSManaged var code: String
    @NSManaged var flag: String
    
    @NSManaged var continent: CDContinent
    @NSManaged var region: CDRegion
    
    var neighbours: [CDCountry]? {
        guard let neighbours = mutableSetValue(forKey: "neighbours").allObjects as? [CDCountry] else {
            return nil
        }
        return neighbours
    }
    
    func add(neighbour: CDCountry) {
        mutableSetValue(forKey: "neighbours").add(neighbour)
    }
    
    
}
