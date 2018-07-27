import UIKit

class ReviewCell: UITableViewCell {
    
    public var name: String? { didSet { nameLabel.text = name }}
    public var review: String? { didSet { reviewLabel.text = review }}
    public var rating: Float? { didSet { self.setRating(rating) }}
    
    private let nameLabel = UILabel()
    private let reviewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.nameLabel.numberOfLines = 1
        self.nameLabel.textColor = Constants.mainColor
        self.nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.cellInset).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.cellInset).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.cellInset).isActive = true

        self.reviewLabel.numberOfLines = 0
        self.reviewLabel.textColor = Constants.mainColor
        self.reviewLabel.font = UIFont.systemFont(ofSize: 14)
        self.reviewLabel.lineBreakMode = .byTruncatingTail
        self.addSubview(self.reviewLabel)
        self.reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.reviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.reviewLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
        self.reviewLabel.rightAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRating(_ rating: Float?) {
        guard let rating = rating else { return }
        let ratingView = RatingView(rating: rating)
        self.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5).isActive = true
        ratingView.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
    }
}
