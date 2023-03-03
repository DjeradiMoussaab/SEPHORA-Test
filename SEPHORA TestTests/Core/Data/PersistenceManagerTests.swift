//
//  PersistenceManagerTests.swift
//  SEPHORA TestTests
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import XCTest
import CoreData
@testable import SEPHORA_Test

class PersistenceManagerTests: XCTestCase {
        

    override class func setUp() {
        super.setUp()
        var productEntity = ProductEntity(context: PersistenceManager.shared.context)
        productEntity.id = 0
        productEntity.name = "test name"
        productEntity.productDescription = "test description"
        productEntity.brand = "test brand"
        productEntity.isSpecial = false
        productEntity.isProductSet = false
        productEntity.image = "test image url"
    }

    override class func tearDown() {
        super.tearDown()

        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(integerLiteral: 0))
        fetchRequest.includesPropertyValues = false

        guard let results = try? PersistenceManager.shared.context.fetch(fetchRequest) else { return }
            
        for result in results {
            PersistenceManager.shared.context.delete(result)
        }
        PersistenceManager.shared.saveContext()

    }
    

    func testPersistenceManager()  {
        let expectation = XCTestExpectation(description: "Persistence manager should not be nil and it's container name should be SEPHORA.")
        
        XCTAssertNotNil(PersistenceManager.shared.container)
        XCTAssertEqual(PersistenceManager.shared.container.name, "SEPHORA")
        expectation.fulfill()
    }

    func testPersistenceSave() {
        
        let expectation = XCTestExpectation(description: "the test product entity should successfuly be saved in the core data and should be retrieved when fetching it.")

        PersistenceManager.shared.saveContext()
        
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(integerLiteral: 0))
         
        guard let results = try? PersistenceManager.shared.context.fetch(fetchRequest) else { return }
        
        XCTAssertNotNil(results.first)
        XCTAssertEqual(results.first?.id, 0)
        
        expectation.fulfill()
        
    }
    
    
}
