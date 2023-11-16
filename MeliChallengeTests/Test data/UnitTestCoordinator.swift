//
//  UnitTestCoordinator.swift
//  MeliChallengeTests
//
//  Created by Martin Gonzalez Vega on 07/11/2023.
//

import UIKit

class UnitTestCoordinator: CoordinatorProtocol {
    
    private (set) var searchValue: String? = nil
    private (set) var selectedItem: String? = nil
    
    var rootViewController = UIViewController()
    
    var childCoordinators = [CoordinatorProtocol]()
    
    func start() { }
    
    func onSearch(withValue value: String) { 
        searchValue = value
    }
    
    func didSelectItem(withId id: String) { }
}
