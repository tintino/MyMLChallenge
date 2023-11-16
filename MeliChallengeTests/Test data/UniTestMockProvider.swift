//
//  UniTestMockProvider.swift
//  MeliChallengeTests
//
//  Created by Martin Gonzalez Vega on 06/11/2023.
//

import Foundation
import Combine

class UniTestMockProvider: ProductsProviderProtocol {
      
    // - MARK: - ProductsProviderProtocol
    
    func searchItem(withDescription description: String) -> AnyPublisher<ResponseSearchItems, Error> {
        let mockData = UnitTestMockDataUtil()
        let response = ResponseSearchItems(results: mockData.mockResponeSearchItems)
        return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func getItem(byId id: String) -> AnyPublisher<ResponseItemDetail, Error> {
        let response = ResponseItemDetail(id: "1", price: 33, title: "33", currency_id: "33", pictures: [RespondeItemPicture]())
        return Just(response)
               .setFailureType(to: Error.self)
               .eraseToAnyPublisher()
    }
}

