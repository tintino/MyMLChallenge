//
//  SearchViewModel.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 25/10/2023.
//

import Foundation
import Combine

class SearchViewModel: SearchViewModelProtocol {
    
    // MARK: - SearchViewModelProtocol
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    var title: LiveData<String>
    
    func viewDidLoad() { }
   
    func onSearch(value: String) { 
        coordinator?.onSearch(withValue: value)
    }
    
    // MARK: - properties
    
    public weak var coordinator: CoordinatorProtocol?
    
    // MARK: - lifecycle
    
    init(withCoordinator coodinator: CoordinatorProtocol) {
        self.title = LiveData<String>(value: .search.translate())
        self.coordinator = coodinator
    }
}
