//
//  AppDelegate.swift
//  Cinematic
//
//  Created by Gurpreet Kaur on 2022-12-15.
//

import UIKit
import CoreData
class AppDelegate: UIResponder, UIApplicationDelegate  {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()

        return true
    }

    // MARK: - Core Data stack

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "the_movie_db")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print(error)
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(nserror)
            }
        }
    }
}


    


