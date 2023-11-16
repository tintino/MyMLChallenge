//
//  ProductDetailViewController.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import UIKit
import OSLog

class ProductDetailViewController: UIViewController {
    
    enum Section: Int, Hashable, CaseIterable {
        case title
        case imageGallery
        case subTitle
    }
    
    struct Item: Hashable {
        let title: String?
        let image: URL?
    }
    
    // MARK: - properties
    
    private let logger: Logger = .appLogger(category: "ProductDetailViewController")
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    private var viewModel: ProductDetailViewModelProtocol?
    private var collectionView: UICollectionView! = nil
    
    // MARK: - lifecycle
    
    init(withViewModel viewModel: ProductDetailViewModelProtocol) {
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
        createInitialSnapshot()
        viewModel?.viewDidLoad()
    }
    
    // MARK: - private methods
    
    private func setupViewController() {
        addCollectionView()
        configureDataSource()
    }
    
    private func bindViewModel() {
        viewModel?.dataSource.bind { [unowned self] product in
            guard let productDetail = product else {
                return
            }
            DispatchQueue.main.async {
                self.updateSnapShot(withItems: productDetail)
            }
        }
    }
    
    private func updateSnapShot(withItems items: ProductDetail) {
        let recentItems = items.images.map { Item(title: nil, image: $0) }
        var recentsSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        recentsSnapshot.append(recentItems)
        dataSource.apply(recentsSnapshot, to: .imageGallery, animatingDifferences: false)
        
        let title = Item(title: items.title, image: nil)
        var titleSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        titleSnapshot.append([title])
        dataSource.apply(titleSnapshot, to: .title, animatingDifferences: false)
        
        let subtitle = Item(title: items.subtitle, image: nil)
        var subTitleSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        subTitleSnapshot.append([subtitle])
        dataSource.apply(subTitleSnapshot, to: .subTitle, animatingDifferences: false)
    }
    
    private func createInitialSnapshot() {
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ProductDetailViewController {
    
    private func addCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: createCollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.backgroundView?.backgroundColor = .red
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        let scrollGalleryRegistation = createGalleryCellRegistration()
        let titleRegistration = createListCellRegistration(withFont: .primary(ofSize: 12, andWeight: .regular))
        let subtitleRegistration = createListCellRegistration(withFont: .primary(ofSize: 22, andWeight: .medium))
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .imageGallery:
                return collectionView.dequeueConfiguredReusableCell(using: scrollGalleryRegistation, for: indexPath, item: item)
            case .title:
                return collectionView.dequeueConfiguredReusableCell(using: titleRegistration, for: indexPath, item: item )
            case .subTitle:
                return collectionView.dequeueConfiguredReusableCell(using: subtitleRegistration, for: indexPath, item: item )
            }
        }
    }
    
    private func createListCellRegistration(withFont font: UIFont) -> UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
        return UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
            guard let title = item.title else { return }
            var content = UIListContentConfiguration.valueCell()
            content.text = title
            content.textProperties.font = font
            var background = UIBackgroundConfiguration.listPlainCell()
            background.backgroundColor = .white
            cell.backgroundConfiguration = background
            cell.contentConfiguration = content
        }
    }
    
    private func createGalleryCellRegistration() -> UICollectionView.CellRegistration<ImageCell, Item> {
        let cellNib = UINib(nibName: "ImageCell", bundle: nil)
        let cellRegistration = UICollectionView.CellRegistration<ImageCell, Item>(cellNib: cellNib) { cell, indexPath, item in
            cell.setupCell(withImageUrl: item.image)
        }
        return cellRegistration
    }
        
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
            case .imageGallery:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            case .title, .subTitle:
                section = NSCollectionLayoutSection.list(using: .init(appearance: .sidebar), layoutEnvironment: layoutEnvironment)
                section.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0)
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}

// MARK: - UICollectionViewDelegate

extension ProductDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
