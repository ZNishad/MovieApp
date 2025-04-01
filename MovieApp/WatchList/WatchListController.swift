//
//  WatchListController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class WatchListController: UIViewController {

    private var movieDetailsList: [MovieDetailsModel] = []

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = .init(
            title: "Watch List",
            image: .watchListIcon.resizeImage(newWidth: 24),
            selectedImage: .watchListIcon.resizeImage(newWidth: 24))
        observeModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pageBack
        view.addSubviews(watchListLabel, collectionView, emptyImage)
        setupUI()
        loadMovieDetailsList()
        hideEmptyImage()
    }

    private lazy var watchListLabel: UILabel = {
        let label = UILabel()
        label.text = "Watch List"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()

    private let emptyImage: UIImageView = {
        let image = UIImage(resource: .emptyWatchList)
        let imageView = UIImageView(image: image)
        return imageView
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(WatchListCell.self, forCellWithReuseIdentifier: "cell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .pageBack
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        return collection
    }()

    private func setupUI() {
        watchListLabel.top(view.safeAreaLayoutGuide.topAnchor, -24).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .height(27)

        emptyImage.centerX(view.centerXAnchor).0
            .centerY(view.centerYAnchor).0
            .width(252).0
            .height(190)

        collectionView.top(watchListLabel.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)
    }

    func saveMovieDetailsList() {
        guard !movieDetailsList.isEmpty else {
            UserDefaults.standard.removeObject(forKey: "movieDetailsList")
            return
        }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(movieDetailsList)
            UserDefaults.standard.set(data, forKey: "movieDetailsList")
        } catch {
            print("Failed to save movie details: \(error)")
        }
    }

    func loadMovieDetailsList() {
        if let data = UserDefaults.standard.data(forKey: "movieDetailsList") {
            let decoder = JSONDecoder()
            do {
                let savedMovies = try decoder.decode([MovieDetailsModel].self, from: data)
                self.movieDetailsList = savedMovies
            } catch {
                print("Failed to load movie details: \(error)")
            }
        } else {
            self.movieDetailsList = []
        }
    }

    @objc private func observeModel() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleMovieAdded(_ :)),
            name: .movieAdded, object: nil)
    }

    @objc func handleMovieAdded(_ notification: Notification) {
        DispatchQueue.main.async {
            guard let movieModel = notification.userInfo?["movieModel"] as? MovieDetailsModel else { return }
            if let index = self.movieDetailsList.firstIndex(where: { $0.id == movieModel.id }) {
                self.movieDetailsList.remove(at: index)
                self.saveMovieDetailsList()
                self.showMessage(title: "Movie Removed", message: "")
            } else {
                self.movieDetailsList.append(movieModel)
                self.saveMovieDetailsList()
                self.showMessage(title: "MovieAdded", message: "")
            }
        }
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.hideEmptyImage()
        })
    }

    private func hideEmptyImage() {
        emptyImage.isHidden = !self.movieDetailsList.isEmpty
    }
}

extension WatchListController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieDetailsList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WatchListCell
        let cellData = movieDetailsList[indexPath.item]
        cell.configureData(imageName: cellData.posterFullPath,
                           name: cellData.title,
                           rate: cellData.voteAverage,
                           date: cellData.releaseDate)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.width * 0.7638
        return CGSize(width: cellWidth, height: cellWidth * 0.39)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let modelId = movieDetailsList[indexPath.item].id else { return }
        let controller = MovieDetailsController(viewModelId: modelId)
        navigationController?.show(controller, sender: nil)
    }
}
