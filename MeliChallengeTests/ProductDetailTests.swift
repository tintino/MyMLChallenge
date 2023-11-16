//
//  MeliChallengeTests.swift
//  MeliChallengeTests
//
//  Created by Martin Gonzalez Vega on 25/10/2023.
//

import XCTest
@testable import MeliChallenge

final class ProductDetailTests: XCTestCase {
    
    var viewModel: ProductDetailViewModelProtocol!
    var coordinator: CoordinatorProtocol!
    var provider: ProductsProviderProtocol!
    
    override func setUpWithError() throws {
        coordinator = UnitTestCoordinator()
        provider = UniTestMockProvider()
        viewModel = ProductDetailViewModel(withCoordinator: coordinator, andProvider: provider, itemId: "MLA1378920085")
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        coordinator = nil
        provider = nil
    }
    
    func testProductDetailViewModel() throws {
        let expectation = XCTestExpectation(description: "DataSource not nil")
        viewModel?.dataSource.bind { product in
            XCTAssertNotNil(product, "dataSource should have values after viewDidLoad")
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 4)
    }
    
    func testPerformanceExample() throws {
        self.measure { }
    }
}


