//
//  ProductDetail.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 05/11/2023.
//

import Foundation

struct ProductDetail: Hashable {
    let id: String
    let subtitle: String
    let title: String
    var images: [URL]
}
