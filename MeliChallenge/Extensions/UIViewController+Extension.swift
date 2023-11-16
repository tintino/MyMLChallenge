//
//  UIViewController+Extension.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 11/11/2023.
//

import UIKit

extension UIViewController {
    func showAlertError(message: String? = nil) {
        let alert = UIAlertController(title: .titleError.translate(),
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: .ok.translate(),
                                   style: .default,
                                   handler: { _ in
            NSLog("The \"OK\" alert occured.")
            })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
