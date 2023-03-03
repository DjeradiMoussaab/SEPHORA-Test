//
//  ProductViewModelTests.swift
//  SEPHORA TestTests
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import XCTest
import RxSwift
@testable import SEPHORA_Test

class ProductViewModelTests: XCTestCase {
    
    private var productListViewModel: ProductListViewModel!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        self.productListViewModel = ProductListViewModel()
    }
    
    func testfetchProductList() {
        
        let expectation = XCTestExpectation(description: "Product List View Model should successfully fetch the products list")
        
        productListViewModel.products
            .map({ products -> [ProductListSection] in
                return products
            })
            .subscribe(onNext: { products in
                XCTAssertEqual(products.count, 2)
                XCTAssertEqual(products[0].items.count, 2)
                XCTAssertEqual(products[1].items.count, 4)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        productListViewModel.fetchProductList(disposeBag)
        wait(for: [expectation], timeout: 2)

    }

}
