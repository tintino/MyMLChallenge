//
//  ProductsListViewModelProtocol.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import Foundation

protocol ProductsListViewModelProtocol: AnyObject {
    var dataSource: LiveData<[ProductListItem]> { get }
    var onError: LiveData<String?> { get }
    var isLoading: LiveData<Bool> { get }
    var title: LiveData<String> { get }
    
    func didSelect(atIndex index: Int)
    func viewDidLoad()
}
