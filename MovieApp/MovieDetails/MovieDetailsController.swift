//
//  MovieDetailsController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class MovieDetailsController: UIViewController {

    private let movieId: Int

    private let viewModel = MovieDetailsViewModel()

    init(viewModelId: Int) {
        movieId = viewModelId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    private let blurEffectView: UIView = {
        let view = UIView()
        view.backgroundColor = .blurEffect
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pageBack
        setupUI()
        setupCallback()
        viewModel.getMovieDetails(movieId: movieId)
    }

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
    }

    func updateUI() {
        backdropImageView.setImage(urlString: viewModel.movieDetails?.backdropFullPath)
        posterImageView.setImage(urlString: viewModel.movieDetails?.posterFullPath)
        movieName.text = viewModel.movieDetails?.originalTitle
        let roundedRate = Int(((viewModel.movieDetails?.voteAverage ?? 0.0)*10).rounded())
        rateCount.text = "\(Double(roundedRate)/10)"
        dateLabel.text = String(viewModel.movieDetails?.releaseDate?.prefix(4) ?? "")
        durationLabel.text = "\(viewModel.movieDetails?.runtime ?? 139) minutes"
        genreLabel.text = viewModel.movieDetails?.genres?.first?.name ?? "N/A"
        aboutMovie.text = viewModel.movieDetails?.overview ?? ""
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
}
