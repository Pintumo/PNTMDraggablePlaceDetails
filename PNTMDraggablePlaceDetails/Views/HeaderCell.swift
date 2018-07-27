import UIKit

class HeaderCell: UITableViewCell {
    
    public var name: String? { didSet { self.nameLabel.text = name }}
    public var isOpen: Bool? { didSet { isOpenLabel.text = isOpen! ? "geöffnet" : "geschlossen" }}
    public var rating: Float? { didSet { self.setRating(rating) }}
    
    let routeButton = UIButton(type: .custom)
    let shareButton = UIButton(type: .custom)
    
    private let nameLabel = UILabel()
    private let isOpenLabel = UILabel()
    private let buttonLine = UIView()
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        self.selectionStyle = .none
        
        self.nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        self.nameLabel.textColor = Constants.mainColor
        self.nameLabel.numberOfLines = 1
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.cellInset).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.cellInset).isActive = true

        self.isOpenLabel.font = UIFont.systemFont(ofSize: 12)
        self.isOpenLabel.textColor = Constants.mainColor
        self.addSubview(self.isOpenLabel)
        self.isOpenLabel.translatesAutoresizingMaskIntoConstraints = false
        self.isOpenLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        self.isOpenLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
        self.isOpenLabel.rightAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
        
        let routeButtonImage = UIImage(named: "icon_travelModel")?.withRenderingMode(.alwaysTemplate)
        self.routeButton.setImage(routeButtonImage, for: .normal)
        self.routeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.routeButton.setTitle("Route with...", for: .normal)
        self.routeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
        self.routeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.routeButton.imageView?.contentMode = .scaleAspectFit
        self.routeButton.imageView?.tintColor = Constants.secondaryColor
        self.routeButton.setTitleColor(Constants.secondaryColor, for: .normal)
        self.routeButton.backgroundColor = Constants.buttonBackgroundColor
        self.routeButton.layer.cornerRadius = 5
        self.addSubview(self.routeButton)
        self.routeButton.translatesAutoresizingMaskIntoConstraints = false
        self.routeButton.topAnchor.constraint(equalTo: self.isOpenLabel.bottomAnchor, constant: 30).isActive = true
        self.routeButton.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
        self.routeButton.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -5).isActive = true
        self.routeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let shareButtonImage = UIImage(named: "icon_share")?.withRenderingMode(.alwaysTemplate)
        self.shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.shareButton.setImage(shareButtonImage, for: .normal)
        self.shareButton.setTitle("Share Location", for: .normal)
        self.shareButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
        self.shareButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.shareButton.imageView?.contentMode = .scaleAspectFit
        self.shareButton.layer.cornerRadius = 5
        self.shareButton.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.shareButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.shareButton.backgroundColor = Constants.secondaryColor
        self.addSubview(self.shareButton)
        self.shareButton.translatesAutoresizingMaskIntoConstraints = false
        self.shareButton.centerYAnchor.constraint(equalTo: self.routeButton.centerYAnchor).isActive = true
        self.shareButton.heightAnchor.constraint(equalTo: self.routeButton.heightAnchor).isActive = true
        self.shareButton.widthAnchor.constraint(equalTo: self.routeButton.widthAnchor).isActive = true
        self.shareButton.rightAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
        
        self.buttonLine.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        self.addSubview(self.buttonLine)
        self.buttonLine.translatesAutoresizingMaskIntoConstraints = false
        self.buttonLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        self.buttonLine.topAnchor.constraint(equalTo: self.shareButton.bottomAnchor, constant: Constants.cellInset + 2).isActive = true
        self.buttonLine.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.buttonLine.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRating(_ rating: Float?) {
        guard let rating = rating else { return }
        let ratingView = RatingView(rating: rating)
        self.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        ratingView.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
    }
}
