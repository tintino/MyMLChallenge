//
//  ServiceSearchItem.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import Foundation
import Combine
import OSLog

class ServiceSearchItem: ProductsProviderProtocol {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "ServiceSearchItem")
    func getItem(byId id: String) -> AnyPublisher<ResponseItemDetail, Error> {
        logger.info("getItem byId: \(id)")
        guard let url: URL = .productDetail(byId: id) else {
            logger.error("getItem bad endpoint url")
            return Fail(error: MeliError.incorrectURL).eraseToAnyPublisher()
        }
       
        return URLSession.shared.dataTaskPublisher(for: url)
            .map( { $0.data } )
            .decode(type: ResponseItemDetail.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func searchItem(withDescription description: String) -> AnyPublisher<ResponseSearchItems, Error> {
        guard let encodedSearchValue = description.percentEncoding() else {
            logger.error("searchItem bad param")
            return Fail(error: MeliError.badSearchParam).eraseToAnyPublisher()
        }
        
        guard let url: URL = .searchItems(percentEncodedParam: encodedSearchValue) else {
            logger.error("searchItem bad url")
            return Fail(error: MeliError.incorrectURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map( { $0.data } )
            .decode(type: ResponseSearchItems.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

