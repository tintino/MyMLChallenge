//
//  ProductItem.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 01/11/2023.
//

import Foundation

struct ProductListItem: Hashable {
    let id: String
    let subtitle: String
    let title: String
    var image: URL?
}
