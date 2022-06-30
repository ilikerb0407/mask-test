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
        
        lsProduct.mapping(product)
        
        
        save(completion: completion)
        
        
    }
    
    func save(completion: (Result<Void>) -> Void = { _ in  }) {
        
        do {
            try viewContext.save()
            
            fetchOrders(completion: { result in

                switch result {

                case .success:
                    
                    completion(Result.success(()))

                case .failure(let error): completion(Result.failure(error))

                }
            })
            
        } catch {
            
            completion(Result.failure(error))
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
        
        
//        for i in 0..<object.features.count {

            
            
//            name?.append(object.features[i].properties.name)
            
            
            
            
            
//            name = object.features[i].properties.name
            
//            id?.append(object.features[i].properties.id)
//
//            phone?.append(object.features[i].properties.phone)
            
//        }
        
        
    }


}


