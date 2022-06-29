//
//  StorageManager.swift
//  mask
//
//  Created by Kai Fu Jhuang on 2022/6/29.
//

import Foundation
import CoreData


typealias LSOrderResults = (Result<[Mask]>) -> Void

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
    
    @objc dynamic var orders: [Mask] = []

    
    // MARK: save to local
    func saveOrder( product: MaskData,
        completion: (Result<Void>) -> Void) {

        let order = Mask(context: viewContext)

        let lsProduct = Mask(context: viewContext)

        lsProduct.mapping(product)
        
        order.name = lsProduct.name
        
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
        
        name = object.features.first?.properties.name
        
        id = object.features.first?.properties.id
        
        phone = object.features.first?.properties.phone
        
    }


}


