//
//  AppDelegate.swift
//  GetSmart
//
//  Created by Vlad Tufis on 05/11/2017.
//  Copyright © 2017 Vlad Tufis. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var coreDataStore: CoreDataStore = CoreDataStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        bootstrap()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        coreDataStore.saveContext()
    }

}

extension AppDelegate {
    
    func bootstrap() {
        let defaults = GetSmartUserDefaults()
        
        print("Defaults.initialized = \(defaults.initialized)")
        
        if !defaults.initialized {
            let reader = PlistReader(filename: "Countries")
            let context = coreDataStore.managedObjectContext
            guard let d = reader.dictionary else {
                print("no dictionary could be loaded from plist")
                return
            }
            
            d.forEach { (continent, countries) in
                
                guard let c = context.save(continent: continent) else {
                    print("could not find last saved continent")
                    return
                }
                countries.forEach({ (country) in
                    guard let region = country["subregion"] as? String else {
                        print("could not find region")
                        return
                    }
                    
                    guard let r = context.save(region: region) else {
                        print("could not find last saved region")
                        return
                    }
                    
                    _ = context.save(country: country, in: c, region: r)
                })
            }
            
            d.forEach({ (continent, countries) in
                countries.forEach({ (country) in
                    
                    guard let code = country["alpha3Code"] as? String else {
                        print("Could not parse code!")
                        return
                    }
                    
                    do {
                        guard let cdc = try context.fetch(CDCountry.with(code: code)).first else {
                            return
                        }
                        guard let neighbours = country["borders"] as? [String] else {
                            print("Could not find neighbours for \(cdc.name)")
                            return
                        }
                        try neighbours.forEach({ (neighbour) in
                            guard let nc = try context.fetch(CDCountry.with(code: neighbour)).first else {
                                return
                            }
                            cdc.add(neighbour: nc)
                        })
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                })
            })
            do {
                try context.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            defaults.initialized = true
        }
    }
    
}
