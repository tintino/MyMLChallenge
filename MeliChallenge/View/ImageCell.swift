//
//  ImageCell.swift
//  MeliChallenge
//
//  Created by Martin Gonzalez Vega on 05/11/2023.
//

import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // - MARK: public methods
    
    public func setupCell(withImageUrl url: URL?) {
        setItemImage(fromURL: url)
    }
    
    // MARK: - private methods
    
    private func setItemImage(fromURL url: URL?) {
      
        let processor = CroppingImageProcessor(size: imageView.frame.size, anchor: CGPoint(x: 0.5, y: 0.5))
        |>  DownsamplingImageProcessor(size: imageView.frame.size)
        
        imageView.kf.indicatorType = .activity

        imageView.kf.setImage(
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

}
