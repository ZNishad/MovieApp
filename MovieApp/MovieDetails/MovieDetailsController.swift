//
//  MovieDetailsController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class MovieDetailsController: UIViewController {

    private var movieId: Int = 0

    private let viewModel = MovieDetailsViewModel()

    init(viewModelId: Int) {
        movieId = viewModelId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pageBack
        setupUI()
        setupCallback()
        viewModel.getMovieDetails(movieId: movieId)
    }

    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()

    private lazy var watchListButton: UIButton = {
        let button = UIButton()
        button.setImage(.watchListAdded, for: .normal)
        return button
    }()

    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let movieName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()

    let rateLogo: UIImageView = {
        let image = UIImage(resource: .star)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var rateCount: UILabel = {
        let rateCount = UILabel()
        rateCount.textColor = .orange
        rateCount.font = .boldSystemFont(ofSize: 12)
        return rateCount
    }()

    private lazy var rateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rateLogo, rateCount])
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.backgroundColor = .clear
        return stackView
    }()

    private lazy var blurEffectView: UIView = {
        let view = UIView()
        view.backgroundColor = .blurEffect
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rateMovie)))
        view.isUserInteractionEnabled = true
        return view
    }()

    private let detailsBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var detailsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateStackView, durationStackView, genreStackView])
        stack.distribution = .equalSpacing
        stack.spacing = 12
        stack.backgroundColor = .clear
        return stack
    }()

    private lazy var dateStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dateLogoView, dateLabel])
        stack.distribution = .fill
        stack.spacing = 5
        stack.backgroundColor = .clear
        return stack
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = ""
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let dateLogoView: UIImageView = {
        let ticket = UIImage(resource: .calendarBlank)
        let imageView = UIImageView(image: ticket)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var durationStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [durationLogoView, durationLabel])
        stack.distribution = .fill
        stack.spacing = 5
        stack.backgroundColor = .clear
        return stack
    }()

    private let durationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = ""
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let durationLogoView: UIImageView = {
        let ticket = UIImage(resource: .clock)
        let imageView = UIImageView(image: ticket)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var genreStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [genreLogoView, genreLabel])
        stack.distribution = .fill
        stack.spacing = 5
        stack.backgroundColor = .clear
        return stack
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = ""
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let genreLogoView: UIImageView = {
        let ticket = UIImage(resource: .ticket)
        let imageView = UIImageView(image: ticket)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let aboutMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "About movie"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()

    private let aboutMovie: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    func setupUI() {
        view.addSubviews(backdropImageView, posterImageView,
                         movieName, blurEffectView, detailsBackView,
                         aboutMovieLabel, aboutMovie)
        blurEffectView.addSubview(rateStackView)
        detailsBackView.addSubview(detailsStackView)

        backdropImageView.top(view.safeAreaLayoutGuide.topAnchor, 24).0
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor).0
            .height(210)
        backdropImageView.layer.cornerRadius = 16
        backdropImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        backdropImageView.clipsToBounds = true

        posterImageView.centerY(backdropImageView.bottomAnchor).0
            .leading(view.leadingAnchor, 24).0
            .width(95).0
            .height(120)
        posterImageView.layer.cornerRadius = 16
        posterImageView.clipsToBounds = true

        movieName.top(backdropImageView.bottomAnchor, 12).0
            .leading(posterImageView.trailingAnchor, 12).0
            .trailing(view.trailingAnchor, -24).0
            .height(50)

        blurEffectView.width(60).0
            .height(30).0
            .trailing(backdropImageView.trailingAnchor, -12).0
            .bottom(backdropImageView.bottomAnchor, -12)

        rateStackView.fillSuperView(padding: .init(top: 4, left: 8, bottom: -4, right: -8))

        detailsBackView.top(movieName.bottomAnchor, 12).0
            .leading(view.leadingAnchor, 50).0
            .trailing(view.trailingAnchor, -50).0
            .height(32)

        detailsStackView.fillSuperView(padding: .init(top: 8, left: 4, bottom: -8, right: -4))

        durationLogoView.setImageColor(color: .gray)
        dateLogoView.setImageColor(color: .gray)
        genreLogoView.setImageColor(color: .gray)

        aboutMovieLabel.top(detailsBackView.bottomAnchor, 24).0
            .centerX(view.centerXAnchor)

        aboutMovie.top(aboutMovieLabel.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 29).0
            .trailing(view.trailingAnchor, -29)

        navigationItem.titleView = detailLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: watchListButton)
    }

    func updateUI() {
        guard let details = viewModel.movieDetails else { return }
        backdropImageView.setImage(urlString: details.backdropFullPath)
        posterImageView.setImage(urlString: details.posterFullPath)
        movieName.text = details.originalTitle
        let roundedRate = Int(((details.voteAverage ?? 0.0)*10).rounded())
        rateCount.text = "\(Double(roundedRate)/10)"
        dateLabel.text = String(details.releaseDate?.prefix(4) ?? "")
        durationLabel.text = "\(details.runtime ?? 139) minutes"
        genreLabel.text = details.genres?.first?.name ?? "N/A"
        aboutMovie.text = details.overview ?? ""
    }

    private func setupCallback() {
        viewModel.callback = {
            [weak self] type in
            guard let self else { return }
            switch type {
            case .loading:
                self.view.showLoader()
            case .loaded:
                self.view.hideLoader()
            case .error(let message):
                self.showMessage(title: "Error", message: message)
            case .reloadData:
                self.updateUI()
            }
        }
    }

    @objc private func rateMovie() {
        guard movieId > 0 else { return }
        presentPanModal(RateController(viewModelId: movieId))
    }
}
