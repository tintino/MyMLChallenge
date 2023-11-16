//
//  SearchViewController.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 25/10/2023.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - properties
    
    private var viewModel: SearchViewModelProtocol?
    
    // MARK: - lifecycle
    
    init(withViewModel viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        bindViewModel()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - private methods
    
    private func setupViewController() {
        searchButton.setTitle(.search.translate(), for: .normal)
        searchButton.isEnabled = false
        searchTextField.placeholder = .searchOnMercadoLibre.translate()
        searchTextField.returnKeyType = .search
        searchTextField.delegate = self
        view.backgroundColor = .brandColor1
        searchButton.tintColor = .brandColor2
    }
    
    private func bindViewModel() {
        viewModel?.title.bind { [unowned self] title in
            DispatchQueue.main.async {
                self.title = title
            }
        }
    }
    
    private func onSearchTapped() {
        guard let text = searchTextField.text else {
            return
        }
        viewModel?.onSearch(value: text)
    }
    
    // MARK: - actions
    
    @IBAction func onSearchTextChanged(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        searchButton.isEnabled = !text.isEmpty
    }
    
    @IBAction func onSearchTouchUpInside(_ sender: Any) {
        onSearchTapped()
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onSearchTapped()
        return false
    }
}
