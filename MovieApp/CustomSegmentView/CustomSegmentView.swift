//
//  CustomSegmentView.swift
//  MovieApp
//
//  Created by Nishad Zulfuqarli on 02.02.25.
//

import UIKit

class CustomSegmentView: UIView {

    var callBack: ((Int) -> Void)?

    private let items: [String]

    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: items.enumerated().map({ index, text in
            let label = UILabel()
            label.tag = index
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.textColor = .white
            label.font = .systemFont(ofSize: 14)
            label.text = text
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(segmentAction(_: ))))
            return label
        }))
        stack.distribution = .fillEqually
        stack.spacing = 2
        return stack
    }()

    private let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .selectedView
        return view
    }()

    private var selectionViewLeading: NSLayoutConstraint?

    private func setupUI() {
        backgroundColor = .pageBack
        addSubview(backView)
        backView.addSubviews(selectedView, stackView)

        backView.fillSuperView()
        stackView.fillSuperView(padding: .init(top: 2, left: 2, bottom: -2, right: -2))
        let multiplier = 1 / CGFloat(items.count)
        let constant = (2 * (CGFloat(items.count - 1)) / CGFloat(items.count))

        selectionViewLeading =  selectedView.bottom(stackView.bottomAnchor).0
            .width(stackView.widthAnchor, multiplier: multiplier, -constant).0
            .height(4).0
            .leading(stackView.leadingAnchor).1
    }

    @objc private func segmentAction(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        moveSelectionView(constant: view.frame.minX)
        callBack?(view.tag)
    }

    func moveToSegment(_ index: Int) {
        let x = stackView.arrangedSubviews[index].frame.minX
        moveSelectionView(constant: x)
    }

    private func moveSelectionView(constant: CGFloat) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            selectionViewLeading?.constant = constant
            self.layoutIfNeeded()
        }
    }

}

