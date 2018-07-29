import UIKit

class HeaderCell: UITableViewCell {
    
    public var name: String? { didSet { self.nameLabel.text = name }}
    public var tags: [String]? { didSet { self.setTags(tags) }}
    public var isOpen: Bool? { didSet { self.setIsOpen(isOpen) }}
    public var rating: Float? { didSet { self.setRating(rating) }}
    
    let routeButton = UIButton(type: .custom)
    let shareButton = UIButton(type: .custom)
    
    private let nameLabel = UILabel()
    private let tagsLabel = UILabel()
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

        self.tagsLabel.font = UIFont.systemFont(ofSize: 12)
        self.tagsLabel.textColor = Constants.mainColor
        self.addSubview(self.tagsLabel)
        self.tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tagsLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        self.tagsLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
        
        self.isOpenLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.isOpenLabel.textColor = Constants.mainColor
        self.addSubview(self.isOpenLabel)
        self.isOpenLabel.translatesAutoresizingMaskIntoConstraints = false
        self.isOpenLabel.centerYAnchor.constraint(equalTo: self.tagsLabel.centerYAnchor).isActive = true
        self.isOpenLabel.leftAnchor.constraint(equalTo: self.tagsLabel.rightAnchor).isActive = true
        self.isOpenLabel.rightAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
        
        let routeButtonImage = Assets.icon_travelModel.image()?.withRenderingMode(.alwaysTemplate)
        self.routeButton.setImage(routeButtonImage, for: .normal)
        self.routeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.routeButton.setTitle(Localizable.routeWith.loc(), for: .normal)
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
        
        let shareButtonImage = Assets.icon_share.image()?.withRenderingMode(.alwaysTemplate)
        self.shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.shareButton.setImage(shareButtonImage, for: .normal)
        self.shareButton.setTitle(Localizable.shareLocation.loc(), for: .normal)
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
        ratingView.topAnchor.constraint(equalTo: self.isOpenLabel.bottomAnchor, constant: 5).isActive = true
        ratingView.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
    }
    
    private func setTags(_ tags: [String]?) {
        if let tags = tags {
            self.tagsLabel.text = tags.prefix(2).joined(separator: " ⋅ ")
        } else {
            self.tagsLabel.text = ""
        }
    }
    
    private func setIsOpen(_ isOpen: Bool?) {
        if let isOpen = isOpen, isOpen {
            self.isOpenLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.isOpenLabel.text = " ⋅ \(Localizable.open.loc())"
        }
        else{
            self.isOpenLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            self.isOpenLabel.text = " ⋅ \(Localizable.closed.loc())" }
    }
}
