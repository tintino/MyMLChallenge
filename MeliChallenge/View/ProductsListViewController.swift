//
//  ProductsListViewController.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import UIKit
import OSLog

class ProductsListViewController: UIViewController {
    
    // MARK: - properties
   
    lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        view.color = .brandColor1
        view.startAnimating()
        return view
    }()
    private let logger: Logger = .appLogger(category: "ProductsListViewController")
    private var dataSource: UICollectionViewDiffableDataSource<Section, ProductListItem>! = nil
    private var viewModel: ProductsListViewModelProtocol?
    private var collectionView: UICollectionView! = nil    
    private enum Section {
        case main
    }
    
    // MARK: - lifecycle
    
    init(withViewModel viewModel: ProductsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        logger.info("deinit")
    }   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        bindViewModel()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - private methods
  
    private func setupViewController() {
        addViews()
        configureDataSource()
        navigationController?.navigationBar.barTintColor = .brandColor1
        navigationController?.navigationBar.backgroundColor = .brandColor1
    }
    
    private func bindViewModel() {
        bindErrorMessage()
        bindDataSource()
    }
    
    private func bindDataSource() {
        indicatorView.startAnimating()
        viewModel?.dataSource.bind { [unowned self] items in
            DispatchQueue.main.async {
                if items.isNotEmpty {
                    self.updateSnapShot(withItems: items)
                    self.indicatorView.stopAnimating()
                }
            }
        }
    }
    
    private func bindErrorMessage() {
        viewModel?.onError.bind { [unowned self] errorMessage in
            guard let message = errorMessage else {
                return
            }
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.showAlertError(message: message)
            }
        }
    }
    
    private func updateSnapShot(withItems items: [ProductListItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductListItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ProductsListViewController {
    
    private func addViews() {
        collectionView = UICollectionView(frame: view.bounds,collectionViewLayout: createCollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureDataSource() {
        let cellNib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        let cellRegistration = UICollectionView.CellRegistration<ItemCollectionViewCell, ProductListItem>(cellNib: cellNib) { cell, indexPath, item in
            cell.setupCell(withCellItem: item)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, ProductListItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: ProductListItem) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, ProductListItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems([ProductListItem]())
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.35))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - UICollectionViewDelegate

extension ProductsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel?.didSelect(atIndex: indexPath.row)
    }
}
