//
//  TopFiveCell.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class TopFiveCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.fillSuperView()
    }

    func configureData(imageName: String?) {
        imageView.image = nil
        guard let imageName else { return }
        imageView.setImage(urlString: imageName)
    }
}

