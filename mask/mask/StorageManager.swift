//
//  StorageManager.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import Foundation
import CoreData


@objc class StorageManager: NSObject {
    
    static let shared = StorageManager()
    
    private override init() {
        
        print(" Core data file path: \(NSPersistentContainer.defaultDirectoryURL())")
    }
    
    // MARK: persistanceContainer
    
    lazy var persistanceContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "mask")

        container.loadPersistentStores(completionHandler: { (_, error) in

            if let error = error {
                 fatalError("Unresolved error \(error)")
            }
        })

        return container
    }()
    
    // MARK: viewContext
    
    var viewContext: NSManagedObjectContext {

        return persistanceContainer.viewContext
    }
   
    
    
    // MARK: save to local
    
    func saveToLocal() {
        
        
        
    }
    
    
    
    
    
    
}


