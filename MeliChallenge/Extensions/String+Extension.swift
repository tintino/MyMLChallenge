//
//  String+Extension.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 08/11/2023.
//

import Foundation

extension String {
    func percentEncoding() -> String? {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    func translate() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func translate(param: String) -> String {
        return NSLocalizedString("\(self) \(param)", comment: "")
    }
}
