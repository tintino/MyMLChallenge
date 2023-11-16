//
//  MainCoordinator.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 25/10/2023.
//

import UIKit

class MainCoordinator: CoordinatorProtocol {
    
    // MARK: - Coordinator Protocol
    
    var rootViewController: UIViewController
    
    var childCoordinators = [CoordinatorProtocol]()
    
    func start() {
        goToSearch()
    }
    
    func onSearch(withValue value: String) {
        goToProductList(withSearchParam: value)
    }
    
    
    func didSelectItem(withId id: String) {
        goToProductDetail(withId: id)
    }
    
    // MARK: - lifecycle
    
    init() {
        self.rootViewController = UINavigationController()
    }
}

extension MainCoordinator {
    
    private func goToSearch() {
        let viewModel = SearchViewModel(withCoordinator: self)
        let viewController = SearchViewController(withViewModel: viewModel)
        if let navigationController = rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: false)
        }
    }
    
    private func goToProductList(withSearchParam param: String) {
        let provider = ServiceSearchItem()
        let viewModel = ProductsListViewModel(withCoordinator: self, andProvider: provider, searchValue: param)
        let viewController = ProductsListViewController(withViewModel: viewModel)
        if let navigationController = rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: false)
        }
    }
    
    private func goToProductDetail(withId id: String) {
        let provider = ServiceSearchItem()
        let viewModel = ProductDetailViewModel(withCoordinator: self, andProvider: provider, itemId: id)
        let viewController = ProductDetailViewController(withViewModel: viewModel)
        if let navigationController = rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: false)
        }
    }
}
