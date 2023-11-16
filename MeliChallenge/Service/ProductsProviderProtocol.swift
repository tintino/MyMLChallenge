//
//  ProductsProvider.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import Foundation
import Combine

protocol ProductsProviderProtocol: AnyObject {
    func searchItem(withDescription description: String) -> AnyPublisher<ResponseSearchItems, Error>
    func getItem(byId id: String) -> AnyPublisher<ResponseItemDetail, Error>
}
