//
//  CoordinatorProtocol.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 25/10/2023.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get set }
    var rootViewController: UIViewController { get set }
    func onSearch(withValue value: String)
    func didSelectItem(withId id: String)
    func start()
}
