//
//  UpcomingController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class UpcomingController: UIViewController {

    private let viewModel = UpcomingViewModel()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SegmentItemCell.self, forCellWithReuseIdentifier: "cell")
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pageBack
        view.addSubviews(collectionView)
        collectionView.fillSuperView()
        setupCallback()
        viewModel.getUpcomingMovieList()
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
            case .errer(let message):
                self.showMessage(title: "Error", message: message)
            case .reloadData:
                self.collectionView.reloadData()
            }
        }
    }
}

extension UpcomingController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SegmentItemCell
        let imagePath = viewModel.getMovieModel(index: indexPath.item)?.posterFullPath
        cell.configureData(imageName: imagePath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.width * 0.2825
        return CGSize(width: cellWidth, height: cellWidth * 1.45)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        13
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        18
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let modelId = viewModel.getMovieModel(index: indexPath.item)?.id else { return }
        let controller = MovieDetailsController(viewModelId: modelId)
        navigationController?.show(controller, sender: nil)
    }
}
