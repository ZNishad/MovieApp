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

    let attributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor.pageBack,
        .strokeColor: UIColor.tabBarSelected,
        .strokeWidth: -1
    ]

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "AvenirNext-Bold", size: 96) ?? UIFont.systemFont(ofSize: 96, weight: .semibold)
        label.attributedText = NSAttributedString(string: " ", attributes: attributes)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.addSubviews(imageView, numberLabel)

        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.fillSuperView()

        numberLabel.centerY(imageView.bottomAnchor, -18).0
            .leading(imageView.leadingAnchor, -11)
    }

    func configureData(imageName: String?, number: String?) {
        imageView.image = nil
        guard let imageName else { return }
        imageView.setImage(urlString: imageName)
        numberLabel.text = number
    }
}

