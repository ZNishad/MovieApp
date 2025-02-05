//
//  SearchCell.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class SearchCell: UICollectionViewCell {

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .clear
        return stack
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Spider-Man"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var rateLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .clear
        label.text = ""
        label.textColor = .orange
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let rateStarLogoView: UIImageView = {
        let star = UIImage(resource: .star)
        let imageView = UIImageView(image: star)
        return imageView
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let dateLogoView: UIImageView = {
        let ticket = UIImage(resource: .calendarBlank)
        let imageView = UIImageView(image: ticket)
        return imageView
    }()

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
        contentView.addSubviews(stackView, imageView)
        stackView.addSubviews(nameLabel, rateStarLogoView, rateLabel, dateLogoView, dateLabel)
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.top(contentView.topAnchor).0
            .leading(contentView.leadingAnchor).0
            .bottom(contentView.bottomAnchor).0
            .width(95)

        stackView.top(contentView.topAnchor).0
            .leading(imageView.trailingAnchor, 12).0
            .trailing(contentView.trailingAnchor).0
            .bottom(contentView.bottomAnchor)

        nameLabel.top(stackView.topAnchor).0
            .leading(stackView.leadingAnchor).0
            .trailing(stackView.trailingAnchor).0
            .height(24)

        rateStarLogoView.bottom(dateLogoView.topAnchor, -14).0
            .leading(stackView.leadingAnchor).0
            .width(16).0
            .height(16)

        rateLabel.bottom(dateLogoView.topAnchor, -14).0
            .leading((rateStarLogoView.trailingAnchor), 4).0
            .trailing(stackView.trailingAnchor).0
            .height(16)


        dateLogoView.bottom(stackView.bottomAnchor, -4).0
            .leading(stackView.leadingAnchor).0
            .width(16).0
            .height(16)

        dateLabel.bottom(stackView.bottomAnchor, -4).0
            .leading((dateLogoView.trailingAnchor), 4).0
            .trailing(stackView.trailingAnchor).0
            .height(16)
    }

    func configureData(imageName: String?, name: String?, rate: Double?, date: String?) {
        imageView.image = nil
        nameLabel.text = nil
        guard let imageName, let name, let rate else { return }
        imageView.setImage(urlString: imageName)
        nameLabel.text = name
        let roundedRate = Int((rate*10).rounded())
        rateLabel.text = "\(Double(roundedRate)/10)"
        dateLabel.text = String(date?.prefix(4) ?? "")
    }

}
