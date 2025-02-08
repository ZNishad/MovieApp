//
//  RateController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 08.02.25.
//

import UIKit

class RateController: UIViewController {
    private var movieId: Int = 0

    private let viewModel = RateViewModel()

    init(viewModelId: Int) {
        movieId = viewModelId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(closeButton, rateIntroLabel, rateLabel, rateSlider, okButton)
        setupUI()
    }

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✕", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.tintColor = .label
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()

    private let rateIntroLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Rate this movie"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()

    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "\(rateSlider.value)"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 32, weight: .bold)
        return label
    }()

    private lazy var rateSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 10.0
        slider.value = 5.0
        slider.minimumTrackTintColor = .orange
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .orange
        slider.addTarget(self, action: #selector(rateValueChanged(_:)), for: .valueChanged)
        return slider
    }()

    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.layer.cornerRadius = 28
        button.backgroundColor = .okButton
        button.addTarget(self, action: #selector(setRating), for: .touchUpInside)
        return button
    }()

    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true

        closeButton.top(view.safeAreaLayoutGuide.topAnchor, 12).0
            .trailing(view.trailingAnchor, -16)

        rateIntroLabel.top(closeButton.centerYAnchor).0
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor).0
            .height(34)

        rateLabel.top(rateIntroLabel.bottomAnchor, 27).0
            .leading(view.leadingAnchor).0
            .trailing(view.trailingAnchor).0
            .height(34)

        rateSlider.top(rateLabel.bottomAnchor, 27).0
            .leading(view.leadingAnchor, 50).0
            .trailing(view.trailingAnchor, -50)

        okButton.top(rateSlider.bottomAnchor, 27).0
            .leading(view.leadingAnchor, 78).0
            .trailing(view.trailingAnchor, -78).0
            .height(56)
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
            case .setRatingSuccess(let message):
                self.showMessage(title: "Success", message: message)
            }
        }
    }

    private var sliderValue: Double = 0.0

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @objc private func rateValueChanged(_ sender: UISlider) {
        let sliderValue = round(sender.value * 2) / 2
        rateLabel.text = "\(sliderValue)"
        self.sliderValue = Double(sliderValue)
    }

    @objc private func setRating() {
        viewModel.setRating(movieId: movieId, rating: sliderValue)
        dismiss(animated: true)
    }

}
