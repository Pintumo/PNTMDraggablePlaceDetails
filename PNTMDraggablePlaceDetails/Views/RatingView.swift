import UIKit

class RatingView: UIView {

    static private let starWidth: CGFloat = 12
    static private let starSpace: CGFloat = 2
    static let width = 5*starWidth + 4*starSpace
    private let rating: CGFloat
    
    
    convenience init(rating: Float) {
        self.init(with: CGFloat(rating))
    }
    
    init(with rating: CGFloat) {
        self.rating = rating
        super.init(frame: .null)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: RatingView.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: RatingView.starWidth).isActive = true
        
        let fullStars = Int(rating)
        let decimal = Int(rating * 10) % 10
        let halfStars = decimal > 2 && decimal < 8 ? 1 : 0
        let emptyStars = 5 - fullStars - halfStars
        
        var stars = [UIImageView]()
        for _ in 0..<fullStars { stars.append(UIImageView(image: UIImage(named: "star_full"))) }
        for _ in 0..<halfStars { stars.append(UIImageView(image: UIImage(named: "star_half"))) }
        for _ in 0..<emptyStars { stars.append(UIImageView(image: UIImage(named: "star_empty"))) }
        
        for (index, star) in stars.enumerated() {
            star.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(star)
            star.translatesAutoresizingMaskIntoConstraints = false
            star.widthAnchor.constraint(equalToConstant: RatingView.starWidth).isActive = true
            star.heightAnchor.constraint(equalToConstant: RatingView.starWidth).isActive = true
            star.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            if (index == 0) {
                star.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            } else {
                star.leftAnchor.constraint(equalTo: stars[index - 1].rightAnchor, constant: 1).isActive = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImageView(_ image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        return imageView
    }
}
