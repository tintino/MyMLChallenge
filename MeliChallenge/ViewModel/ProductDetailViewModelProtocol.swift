//
//  ProductDetailViewModelProtocol.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import Foundation

protocol ProductDetailViewModelProtocol: AnyObject {
    var dataSource: LiveData<ProductDetail?> { get }
    var onError: LiveData<String?> { get }
    var isLoading: LiveData<Bool> { get }
    func viewDidLoad()
}
