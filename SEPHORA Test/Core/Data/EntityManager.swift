//
//  EntityManager.swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import CoreData


protocol EntityManagerProtocol {
    associatedtype Entity
    associatedtype Model
    
    func save(model: [Model])
    func transform(entity: Entity) -> Model
    func transform(model: Model) -> Entity
    func fetchAll() -> [ProductEntity]?

}

class ProductEntityManager: EntityManagerProtocol {
    
    typealias Entity = ProductEntity
    
    typealias Model = Product
    
    func save(model: [Product]) {
        _ = model
            .filter { !entityExist(with: $0.id) }
            .map { transform(model: $0) }
        
        PersistenceManager.shared.saveContext()
    }
    
    func transform(model: Product) -> ProductEntity {
        return ProductEntity(product: model)
    }
    
    func transform(entity: ProductEntity) -> Product {
        return Product(managedObject: entity)
    }
    
    func fetchAll() -> [ProductEntity]? {
        let fetchRequest: NSFetchRequest<ProductEntity> = Entity.fetchRequest()
        guard let objects = try? PersistenceManager.shared.context.fetch(fetchRequest) else { return nil }
        return objects.reversed()
    }
    
    func entityExist(with id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(integerLiteral: id))
         
        guard let results = try? PersistenceManager.shared.context.fetch(fetchRequest) else { return false }
        guard let _ = results.first else { return false }

        return true
    }
    
}
