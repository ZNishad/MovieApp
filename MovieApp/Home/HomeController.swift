//
//  HomeController.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class HomeController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = .init(
            title: "Home",
            image: .homeIcon.resizeImage(newWidth: 24),
            selectedImage: .homeIcon.resizeImage(newWidth: 24))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    private lazy var viewModel: HomeViewModel = {
//        guard let navigationController else {
//            return .init(coordinator: nil)
//        }
//        return .init(coordinator: .init(navigationController: navigationController))
//    }()
    private let viewModel = HomeViewModel()

    private let segmentView = CustomSegmentView(items: [
        "Now Playing", "Upcoming", "Top rated", "Popular"
    ])

    private lazy var subController = [
        NowPlayingController(),
        UpcomingController(),
        TopRatedController(),
        PopularController()
    ]

    let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

    private let introLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to watch?"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TopFiveCell.self, forCellWithReuseIdentifier: "cell")
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .pageBack
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()

    override func viewDidLoad() {
        view.backgroundColor = .pageBack
        view.addSubviews(introLabel, collectionView, segmentView, pageController.view)

        pageController.delegate = self
        pageController.dataSource = self
        addChild(pageController)

        setupUI()
        setupCallback()
        viewModel.getTopRatedMovieList()
    }

    private func setupUI() {
        introLabel.top(view.safeAreaLayoutGuide.topAnchor, -24).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .height(27)

        collectionView.top(introLabel.bottomAnchor, 21).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .bottom(view.centerYAnchor, -view.frame.height/8)

        segmentView.top(collectionView.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .height(40)

        pageController.view.top(segmentView.bottomAnchor, 20).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .bottom(view.safeAreaLayoutGuide.bottomAnchor)

        segmentView.callBack = { [weak self] index in
            guard let self else { return }
            self.moveToController(index)
        }

        pageController.view.backgroundColor = .pageBack
        pageController.setViewControllers([subController.first!], direction: .forward, animated: false)
    }

    private var currentIndex: Int = 0

    func moveToController(_ index: Int) {
        let controller = subController[index]
        pageController.setViewControllers([controller], direction: index < currentIndex ? .reverse : .forward, animated: true)
        currentIndex = index
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
            }
        }
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TopFiveCell
        let imagePath = viewModel.movieImagePath(index: indexPath.item)
        cell.configureData(imageName: imagePath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 145,
               height: 210)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let modelId = viewModel.movieModelId(index: indexPath.item) else { return }
        let controller = MovieDetailsController(viewModelId: modelId)
        navigationController?.show(controller, sender: nil)
    }
}

extension HomeController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = subController.firstIndex(of: viewController), index > 0 else { return nil }
        return subController[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = subController.firstIndex(of: viewController), index < subController.count - 1 else { return nil }
        return subController[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let visibleController = pageViewController.viewControllers?.first,
              let index = subController.firstIndex(of: visibleController) else { return }
        currentIndex = index
        segmentView.moveToSegment(index)
    }
}
