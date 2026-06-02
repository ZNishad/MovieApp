import UIKit

class CustomTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topLine)
        isTranslucent = false
        backgroundColor = .pageBack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let topLine: UIView = {
        let view = UIView()
        view.backgroundColor = .tabBarSelected
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .pageBack

        var newFrame = frame
        newFrame.size.height = 80
        newFrame.origin.y = (superview?.frame.height ?? 0) - 80
        frame = newFrame

        topLine.frame = CGRect(x: 0, y: 0, width: frame.width, height: 1)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var newSize = super.sizeThatFits(size)
        newSize.height = 80
        return newSize
    }
}
