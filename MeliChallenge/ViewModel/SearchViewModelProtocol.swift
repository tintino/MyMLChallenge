//
//  SearchViewModelProtocol.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 25/10/2023.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    var title: LiveData<String> { get }
    func viewDidLoad()
    func onSearch(value: String)
}
