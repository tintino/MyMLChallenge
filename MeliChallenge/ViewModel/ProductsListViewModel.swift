//
//  ProductsListViewModel.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import Foundation
import Combine
import OSLog

class ProductsListViewModel: ProductsListViewModelProtocol {
    
    // MARK: - ProductsListViewModelProtocol
    
    var dataSource: LiveData<[ProductListItem]>
    var onError: LiveData<String?>
    var isLoading: LiveData<Bool>
    var title: LiveData<String>
    
    func viewDidLoad() {
        getProductsList(bySearchValue: searchValue)
    }
    
    func didSelect(atIndex index: Int) {
        goToProductDetail(atIndex: index)
    }
    
    // MARK: - properties
    private let logger: Logger = .appLogger(category: "ProductsListViewModel")
    private var cancellableSet: Set<AnyCancellable> = []
    private weak var coordinator: CoordinatorProtocol?
    private var provider: ProductsProviderProtocol?
    private var searchValue: String
    
    // MARK: - lifecycle
    
    init(withCoordinator coordinator: CoordinatorProtocol, andProvider provider: ProductsProviderProtocol, searchValue value: String) {
        logger.info("withCoordinator")
        self.title = LiveData<String>(value: "Products")
        self.dataSource = .init(value: [ProductListItem]())
        self.isLoading = .init(value: false)
        self.onError = .init(value: nil)
        self.coordinator = coordinator
        self.searchValue = value
        self.provider = provider
    }
    
    deinit {
        logger.info("deinit")
    }
    
    // MARK: - private methods
    
    private func goToProductDetail(atIndex index: Int) {
        guard let item = dataSource.value[safeIndex: index] else {
            logger.error("goToProductDetail unsafe index selected")
            return
        }
        logger.info("goToProductDetail: \(item.id)")
        coordinator?.didSelectItem(withId: item.id)
    }
    
    private func getProductsList(bySearchValue value: String) {
        isLoading.value = true
        logger.info("getProductsList for \(value)")
        provider?.searchItem(withDescription: value)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.onError.value = .userError.translate(param: error.localizedDescription)
                case .finished:
                    self.logger.info("get products for: \(value) finished")
                }
                self.isLoading.value = false
            } receiveValue: { response in
                self.createDataSource(fromResponse: response.results)
            }.store(in: &cancellableSet)
    }
    
    private func createDataSource(fromResponse responseDateList: [ResponseItem]) {
        let mapResult = responseDateList.map {
            let price = "\($0.currency_id) \($0.price)"
            return ProductListItem(id: $0.id, subtitle: price , title: $0.title, image: nil)
        }
        dataSource.value = mapResult
        
        for i in  responseDateList.indices {
            let item =  responseDateList[i]
            self.logger.info("get pictures for: \(item.id) started")
            provider?.getItem(byId: item.id)
                .sink { result in
                    switch result {
                    case .failure(let error):
                        self.onError.value = .userError.translate(param: error.localizedDescription)
                    case .finished:
                        self.logger.info("get pictures for: \(item.id) finished")
                    }
                } receiveValue: { response in
                    guard let firstImage = response.pictures.first?.secure_url else {
                        return
                    }
                    self.dataSource.value[i].image = URL(string: firstImage)
                    
                }.store(in: &cancellableSet)
        }
    }
}
