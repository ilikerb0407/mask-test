//
//  StorageManager.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import Foundation
import CoreData


typealias LSOrderResults = (Result<[Mask]>) -> Void

class StorageManager {
    
    static let shared = StorageManager()
    
    init() {
        
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
    
    @objc dynamic var orders: [Mask] = []
    
    // MARK: save to local
    
    
    
    func saveOrder(product: MaskData,
                   completion: (Result<Void>) -> Void) {
        
        var lsProduct = Mask(context: viewContext)
     
    
        for i in 0..<product.features.count  {
            
            lsProduct.name?.append(product.features[i].properties.name)
            
            
            lsProduct.phone?.append(product.features[i].properties.phone)
            
            
            lsProduct.id?.append(product.features[i].properties.id)
            
            lsProduct.mapping(product)
        }
        
        save(completion: completion)
        

    }
    
    func save(completion: (Result<Void>) -> Void = { _ in  }) {
        
        let context = viewContext
        
        if context.hasChanges {
            
            do {
                
                try viewContext.save()
                
                completion(.success(()))
                
            } catch {
                
                completion(Result.failure(error))
            }
        }
    }
    
    func fetchOrders(completion: LSOrderResults = { _ in }) {
        
        let request = NSFetchRequest<Mask>(entityName: "Mask")
        
        do {
            
            let orders = try viewContext.fetch(request)
            
            self.orders = orders
            
            completion(Result.success(orders))
            
        } catch {
            
            completion(Result.failure(error))
        }
    }
    
    func deleteOrder(_ order: Mask, completion: (Result<Void>) -> Void) {
        
        viewContext.delete(order)
        
        save(completion: completion)
    }
    
    
    
}

// MARK: - Data Operation
private extension Mask {
    
    func mapping(_ object: MaskData) {
        
        
        name = object.features.first?.properties.name
        
        phone = object.features.first?.properties.phone
        
        id = object.features.first?.properties.phone
        
    
    }

}
