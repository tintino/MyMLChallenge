//
//  Array+extension.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 04/11/2023.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
    
    public var isNotEmpty: Bool {
        !isEmpty
    }
}
