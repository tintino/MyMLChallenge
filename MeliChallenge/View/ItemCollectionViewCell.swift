//
//  ItemCollectionViewCell.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 26/10/2023.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {
    
    // - MARK: @IBOutlets
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // - MARK: lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        itemImage.contentMode = .scaleAspectFill
        separatorView.backgroundColor = .blue
        titleLabel.font = .primary(ofSize: 12, andWeight: .light)
        subtitleLabel.font = .primary(ofSize: 18, andWeight: .regular)
        separatorView.backgroundColor = .lightGray
    }
    
    override func prepareForReuse() {
        itemImage.image = nil
        subtitleLabel.text = ""
        titleLabel.text = ""
    }
    
    // - MARK: private methods
    
    private func setItemImage(fromURL url: URL?) {
      
        let processor = CroppingImageProcessor(size: itemImage.frame.size, anchor: CGPoint(x: 0.5, y: 0.5))
        |>  DownsamplingImageProcessor(size: itemImage.frame.size)
        |> RoundCornerImageProcessor(cornerRadius: 8)
        
        itemImage.kf.indicatorType = .activity

        itemImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - public methods
    
    public func setupCell(withCellItem item: ProductListItem) {
        subtitleLabel.text = item.subtitle
        setItemImage(fromURL: item.image)
        titleLabel.text = item.title
    }
}
