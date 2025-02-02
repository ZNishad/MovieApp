//
//  SearchController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class SearchController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = .init(
            title: "Search",
            image: .searchIcon.resizeImage(newWidth: 24),
            selectedImage: .searchIcon.resizeImage(newWidth: 24))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let viewModel = SearchViewModel()

    private let emptyImage: UIImageView = {
        let image = UIImage(resource: .searchCanNotBeFound)
        let imageView = UIImageView(image: image)
        return imageView
    }()

    override func viewDidLoad() {
        view.backgroundColor = .pageBack
        view.addSubviews(introLabel, searchField, collectionView, imageView, emptyImage)
        setupUI()
        setupCallback()
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SearchCell.self, forCellWithReuseIdentifier: "searchCell")
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    private let introLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    lazy var imageView: UIImageView = {
        let image = UIImage(resource: .searchIcon)
        var imageView = UIImageView(image: image.resizeImage(newWidth: 24))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchIconAction)))
        return imageView
    }()

    lazy var searchField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .searchFieldBack
        field.attributedPlaceholder = NSAttributedString(
            string: "Search movie",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.tabBarUnselected])
        field.textColor = .white
        field.layer.cornerRadius = 16
        field.addTarget(self, action: #selector(searchIconAction), for: .primaryActionTriggered)
        return field
    }()

    private func setupUI() {
        introLabel.top(view.safeAreaLayoutGuide.topAnchor, -24).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .height(27)

        searchField.top(introLabel.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .height(42)

        imageView.centerY(searchField.centerYAnchor).0
            .trailing(searchField.trailingAnchor, -24)

        imageView.setImageColor(color: .tabBarUnselected)
        searchField.addPadding(.both(24))

        collectionView.top(searchField.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor, -24)

        emptyImage.centerX(view.centerXAnchor).0
            .centerY(view.centerYAnchor).0
            .width(252).0
            .height(190)
    }

    @objc func searchIconAction() {
        guard let text = searchField.text else { return }
        viewModel.getSearchMovieList(search: text)
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
                self.collectionView.reloadData()
            case .hideImage(let bool):
                if bool {
                    emptyImage.isHidden = true
                } else {
                    emptyImage.isHidden = false
                }
            }
        }
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCell
        let cellData = viewModel.cellData(index: indexPath.item)
        cell.configureData(imageName: cellData?.posterFullPath,
                           name: cellData?.title,
                           rate: cellData?.voteAverage,
                           date: cellData?.releaseDate)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 307,
               height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        24
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let modelId = viewModel.movieModelId(index: indexPath.item) else { return }
        let controller = MovieDetailsController(viewModelId: modelId)
        navigationController?.show(controller, sender: nil)
    }

}
