//
//  LiveData.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 25/10/2023.
//

import Foundation

class LiveData<T> {
    
    // MARK: - properties
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // MARK: - lifecycle
    
    init(value: T) {
        self.value = value
    }
    
    // MARK: - public methods
    
    public func bind(listener: Listener?) {
        self.listener = listener
        self.listener?(value)
    }
    
    public func notifyListener() {
        listener?(value)
    }
}
