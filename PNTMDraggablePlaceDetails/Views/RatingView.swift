import SnapKit
import UIKit


class RatingView: UIView {
    
    // has to change star graphic depending
    // on places provider
    // y for yelp, g for google
    enum starType {
        case g
        case y
    }
    
    enum starSize {
        case empty
        case half
        case full
    }
    
    static let starWidth: CGFloat = 12
    static let starSpace: CGFloat = 2
    static let width = 5*starWidth + 4*starSpace
    
    init(with rating: CGFloat, starType: starType = .g) {
        super.init(frame: .null)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(RatingView.width)
            make.height.equalTo(RatingView.starWidth)
        }
        
        let fullStars = Int(rating)
        let decimal = Int(rating * 10) % 10
        let halfStar = decimal > 2 && decimal < 8 ? true : false
        
        var emptyStarViews = [UIImageView]()
        for index in 0..<5 {
            let emptyStarView = imageView(for: .empty, starType: starType, fullstars: fullStars)
            emptyStarViews.append(emptyStarView)
            self.addSubview(emptyStarView)
            emptyStarView.snp.makeConstraints { make in
                make.width.height.equalTo(RatingView.starWidth)
                make.centerY.equalTo(self)
                if (index == 0) { make.left.equalTo(self) }
                else { make.left.equalTo(emptyStarViews[index - 1].snp.right).offset(RatingView.starSpace) }
            }
        }
        
        for index in 0..<fullStars {
            let fullStarView = imageView(for: .full, starType: starType, fullstars: fullStars)
            self.addSubview(fullStarView)
            fullStarView.snp.makeConstraints { make in
                make.edges.equalTo(emptyStarViews[index])
            }
        }
        
        if halfStar {
            let halfstarView = imageView(for: .half, starType: starType, fullstars: fullStars)
            self.addSubview(halfstarView)
            halfstarView.snp.makeConstraints { make in
                make.top.left.bottom.equalTo(emptyStarViews[fullStars])
                if starType == .g {
                    make.right.equalTo(emptyStarViews[fullStars].snp.right)
                } else {
                    make.right.equalTo(emptyStarViews[fullStars].snp.centerX)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func imageView(for starSize: starSize, starType: starType, fullstars: Int) -> UIImageView {
        var imageView: UIImageView
        switch starSize {
        case .empty:
            let image = starType == .g ? Assets.star_empty.image() : Assets.star_empty_y.image()
            imageView = UIImageView(image: image)
        case .half:
            let image = starType == .g ? Assets.star_half.image() : Assets.star_half_y.image()
            imageView = UIImageView(image: image)
            if starType != .g {
                imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = color(for: fullstars)
            }
        case .full:
            let image = starType == .g ? Assets.star_full.image() : Assets.star_empty_y.image()
            imageView = UIImageView(image: image)
            if starType != .g {
                imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = color(for: fullstars)
            }
        }
        return imageView
    }
    
    private func color(for stars: Int) -> UIColor {
        switch stars {
        case 5:
            return Color.stars_y_5.set()
        case 4:
            return Color.stars_y_4.set()
        case 3:
            return Color.stars_y_3.set()
        case 2:
            return Color.stars_y_2.set()
        default:
            return Color.stars_y_1.set()
        }
    }
}
