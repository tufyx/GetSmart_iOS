//
//  CoreDataStore.swift
//  GetSmart
//
//  Created by Tufyx on 09/12/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStore {

    fileprivate lazy var applicationDocumentDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }()
    
    fileprivate lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "World", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentDirectory.appendingPathComponent("GetSmart.sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        
        do {
            try coordinator.addPersistentStore(
                ofType: NSSQLiteStoreType,
                configurationName: nil,
                at:url,
                options: options
            )
            print("Successfully loaded the new database")
            coordinator.persistentStores.forEach({ (store) in
                print("url > \(store.url)")
            })
        } catch {
            fatalError("Couldn't load database: \(error)")
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }
    
    func delete(object: NSManagedObject) {
        managedObjectContext.delete(object)
        saveContext()
    }
    
}

extension NSManagedObjectContext {
    
    func save(continent: String) -> CDContinent? {
        let entity = NSEntityDescription.entity(forEntityName: "CDContinent", in: self)
        let c = NSManagedObject(entity: entity!, insertInto: self)
        let name = continent.capitalized
        c.setValue(continent.capitalized, forKey: "name")
        
        do {
            try self.save()
            return try self.fetch(CDContinent.with(name: name)).first
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func save(country: [String: Any], in continent: CDContinent, region: CDRegion) -> CDCountry? {
        let entity = NSEntityDescription.entity(forEntityName: "CDCountry", in: self)
        let c = NSManagedObject(entity: entity!, insertInto: self)
        let code = country["alpha3Code"] as! String
        c.setValue(country["name"] as! String, forKeyPath: "name")
        c.setValue(code, forKeyPath: "code")
        c.setValue(country["flag"] as! String, forKeyPath: "flag")
        c.setValue(country["capital"] as! String, forKeyPath: "capital")
        c.setValue(continent, forKeyPath: "continent")
        c.setValue(region, forKeyPath: "region")
        
        do {
            try self.save()
            return try self.fetch(CDCountry.with(code: code)).first
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func save(region: String) -> CDRegion? {
        let entity = NSEntityDescription.entity(forEntityName: "CDRegion", in: self)
        let r = NSManagedObject(entity: entity!, insertInto: self)
        r.setValue(region, forKey: "name")
        
        do {
            try self.save()
            return try self.fetch(CDRegion.with(name: region)).first
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
