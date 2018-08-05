import UIKit

class ReviewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let reviewLabel = UILabel()
    var rating: Float? { didSet { self.setRating(rating) }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none

        self.nameLabel.numberOfLines = 1
        self.nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.addSubview(self.nameLabel)
        let leftOffset = Constants.cellInset + 5 * RatingView.starWidth + 4 * RatingView.starSpace + 5
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.cellInset).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.cellInset).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftOffset).isActive = true

        self.reviewLabel.numberOfLines = 0
        self.reviewLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        self.reviewLabel.lineBreakMode = .byTruncatingTail
        self.addSubview(self.reviewLabel)
        self.reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.reviewLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        self.reviewLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.cellInset).isActive = true
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
        ratingView.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor).isActive = true
        ratingView.leftAnchor.constraint(equalTo: self.reviewLabel.leftAnchor).isActive = true
    }
}
