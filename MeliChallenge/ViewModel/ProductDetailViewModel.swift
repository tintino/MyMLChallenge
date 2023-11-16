//
//  ProductDetailViewModel.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import Foundation
import Combine
import OSLog

class ProductDetailViewModel: ProductDetailViewModelProtocol {

    // MARK: - ProductDetailViewModelProtocol
    
    var dataSource: LiveData<ProductDetail?>
    var onError: LiveData<String?>
    var isLoading: LiveData<Bool>
        
    func viewDidLoad() {
        getProductDetail()
    }
    
    // MARK: - properties
    private let logger: Logger = .appLogger(category: "ProductDetailViewModel")
    private var cancellableSet: Set<AnyCancellable> = []
    private weak var coordinator: CoordinatorProtocol?
    private var provider: ProductsProviderProtocol?
    private var itemId: String

    // MARK: - lifecycle
    
    init(withCoordinator coordinator: CoordinatorProtocol, andProvider provider: ProductsProviderProtocol, itemId id: String) {
        logger.info("withCoordinator")
        self.dataSource = LiveData<ProductDetail?>(value: nil)
        self.isLoading = .init(value: false)
        self.onError = .init(value: nil)
        self.coordinator = coordinator
        self.provider = provider
        self.itemId = id
    }    
    
    deinit {
        logger.info("deinit")
    }
    
    // MARK: - private methods
    
    private func getProductDetail() {
        logger.info("getProductDetail for \(self.itemId)")
        isLoading.value = true
        provider?.getItem(byId: itemId)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.onError.value = .userError.translate(param: error.localizedDescription)
                case .finished:
                    self.logger.info("getItem for: \(self.itemId) finished")
                }
                self.isLoading.value = false
            } receiveValue: { response in
                self.createDataSource(fromResponse: response)
            }.store(in: &cancellableSet)
    }
    
    private func createDataSource(fromResponse response: ResponseItemDetail) {
        let images = response.pictures.compactMap { responsePicture in
            URL(string: responsePicture.secure_url)
        }
        dataSource.value =  ProductDetail(id: response.id, subtitle: "\(response.currency_id) \(response.price)", title: "\(response.title)", images: images)
    }
}
