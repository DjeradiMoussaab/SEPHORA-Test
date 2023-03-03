//
//  APIClientTests.swift
//  SEPHORA TestTests
//
//  Created by Moussaab Djeradi on 3/3/2023.
//


import XCTest
import RxSwift
@testable import SEPHORA_Test

class APIClientTests: XCTestCase {
    
    private var apiClient: APIClientProtocol!
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        apiClient = APIClient(APIManagerMock())
    }
    
    override func tearDown() {
        apiClient = nil
    }
    
    func testPerformEndpoint() async {
        let expectation = XCTestExpectation(description: "API Client should successfully perform the request to the endpoint.")
        
        
        apiClient.perform(EndpointMock.getProductList)
            .map({ product -> [Product] in
                return product
            })
            .subscribe(onNext: { products  in
                XCTAssertEqual(products.count, 4)
                expectation.fulfill()
            }, onError: { error in
                XCTFail("Error : \(error)")
                return
            })
            .disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
    }

}

