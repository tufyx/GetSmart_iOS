//
//  Region.swift
//  GetSmart
//
//  Created by Tufyx on 09/12/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import CoreData

class CDRegion: NSManagedObject {
    
    @NSManaged var name: String
    
    var countries: [CDCountry]? {
        guard let c = mutableSetValue(forKey: "countries").allObjects as? [CDCountry] else {
            return nil
        }
        return c
    }
    
    static let all: NSFetchRequest<CDRegion> = NSFetchRequest<CDRegion>(entityName: "CDRegion")
    
    static func with(name: String) -> NSFetchRequest<CDRegion> {
        let request = NSFetchRequest<CDRegion>(entityName: "CDRegion")
        request.predicate = NSPredicate(format: "name == %@", name)
        request.fetchLimit = 1
        return request
    }
    
}
