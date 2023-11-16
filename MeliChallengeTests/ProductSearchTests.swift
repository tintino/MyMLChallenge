//
//  ProductSearchTests.swift
//  MeliChallengeTests
//
//  Created by Martin Gonzalez Vega on 07/11/2023.
//

import XCTest
@testable import MeliChallenge

final class ProductSearchTests: XCTestCase {
    
    var viewModel: ProductsListViewModelProtocol!
    var coordinator: UnitTestCoordinator!
    var provider: ProductsProviderProtocol!
    
    override func setUpWithError() throws {
        coordinator = UnitTestCoordinator()
        provider = UniTestMockProvider()
        viewModel = ProductsListViewModel(withCoordinator: coordinator,
                                          andProvider: provider,
                                          searchValue: "Toyota Corolla")
    }
    
    override func tearDownWithError() throws {
        coordinator = nil
        viewModel = nil
        provider = nil
    }
    
    func testProductDetailViewModel() throws {
        let expectation = XCTestExpectation(description: "DataSource not nil")
        viewModel?.dataSource.bind { product in
            XCTAssertNotNil(product, "dataSource should have values after viewDidLoad")
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 1)
    }
    
    func testProductDetailAction() throws {
        let mockUtils = UnitTestMockDataUtil()
        let expectation = XCTestExpectation(description: "DataSource not nil")
        viewModel?.dataSource.bind { product in
            XCTAssertNotNil(product, "dataSource should have values after viewDidLoad")
            expectation.fulfill()
        }
        viewModel.viewDidLoad()
        wait(for: [expectation], timeout: 1)
        
        guard let mockIndex = mockUtils.validMockSearchItemIndex else {
            return XCTFail("invalid test mock data")
        }
        viewModel?.didSelect(atIndex: mockIndex)
        
        XCTAssertNil(coordinator.searchValue, "searchValue shoul be not nil after diSelect")        
    }
    
    func testPerformanceExample() throws {
        self.measure { }
    }
}

