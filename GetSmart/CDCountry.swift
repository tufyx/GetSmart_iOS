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
    
    @NSManaged var name: String
    @NSManaged var capital: String
    
}
