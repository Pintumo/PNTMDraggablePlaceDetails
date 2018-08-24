import UIKit

class HeaderCell: UITableViewCell {
    
    public var name: String? { didSet { self.nameLabel.text = name }}
    public var tags: [String]? { didSet { self.setTags(tags) }}
    public var isOpen: Bool? { didSet { self.setIsOpen(isOpen) }}
    public var rating: Float? { didSet { self.setRating(rating) }}
    public var priceLevel: Int? { didSet { self.setPriceLevel(priceLevel) }}
    
    let routeButton = UIButton(type: .custom)
    let shareButton = UIButton(type: .custom)
    
    private let nameLabel = UILabel()
    private let tagsLabel = UILabel()
    private let isOpenLabel = UILabel()
    private var ratingView: RatingView?
    
    init(mainColor: UIColor) {
        super.init(style: .default, reuseIdentifier: nil)
        self.selectionStyle = .none
        
        let buttonHeigth: CGFloat = 40
        
        self.nameLabel.font = Constants.headerFont
        self.nameLabel.textColor = mainColor
        self.nameLabel.numberOfLines = 1
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.cellInset).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.cellInset).isActive = true
        
        self.tagsLabel.font = Constants.subLabelFont
        self.tagsLabel.textColor = Constants.mainColor
        self.addSubview(self.tagsLabel)
        self.tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.tagsLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        self.tagsLabel.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
        
        self.isOpenLabel.font = Constants.subLabelFont
        self.isOpenLabel.textColor = Constants.mainColor
        self.addSubview(self.isOpenLabel)
        self.isOpenLabel.translatesAutoresizingMaskIntoConstraints = false
        self.isOpenLabel.centerYAnchor.constraint(equalTo: self.tagsLabel.centerYAnchor).isActive = true
        self.isOpenLabel.leftAnchor.constraint(equalTo: self.tagsLabel.rightAnchor).isActive = true
        self.isOpenLabel.rightAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
        
        self.routeButton.layer.cornerRadius = buttonHeigth/2.0
        self.routeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.routeButton.setTitle(Localizable.routeWith.loc(), for: .normal)
        self.routeButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
        self.routeButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.routeButton.imageView?.contentMode = .scaleAspectFit
        self.routeButton.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.routeButton.setTitleColor(.white, for: .normal)
        self.routeButton.backgroundColor = mainColor
        self.addSubview(self.routeButton)
        self.routeButton.translatesAutoresizingMaskIntoConstraints = false
        self.routeButton.topAnchor.constraint(equalTo: self.isOpenLabel.bottomAnchor, constant: 50).isActive = true
        self.routeButton.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
        self.routeButton.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -5).isActive = true
        self.routeButton.heightAnchor.constraint(equalToConstant: buttonHeigth).isActive = true
        
        self.shareButton.layer.cornerRadius = self.routeButton.layer.cornerRadius
        self.shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        self.shareButton.setTitle(Localizable.shareLocation.loc(), for: .normal)
        self.shareButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
        self.shareButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        self.shareButton.imageView?.contentMode = .scaleAspectFit
        self.shareButton.imageView?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.shareButton.setTitleColor(.white, for: .normal)
        self.shareButton.backgroundColor = mainColor
        self.addSubview(self.shareButton)
        self.shareButton.translatesAutoresizingMaskIntoConstraints = false
        self.shareButton.centerYAnchor.constraint(equalTo: self.routeButton.centerYAnchor).isActive = true
        self.shareButton.heightAnchor.constraint(equalTo: self.routeButton.heightAnchor).isActive = true
        self.shareButton.widthAnchor.constraint(equalTo: self.routeButton.widthAnchor).isActive = true
        self.shareButton.rightAnchor.constraint(equalTo: self.nameLabel.rightAnchor).isActive = true
        
        let buttonLine = UIView()
        buttonLine.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        self.addSubview(buttonLine)
        buttonLine.translatesAutoresizingMaskIntoConstraints = false
        buttonLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        buttonLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonLine.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Constants.cellInset).isActive = true
        buttonLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.cellInset).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRating(_ rating: Float?) {
        guard let rating = rating else { return }
        self.ratingView = RatingView(rating: rating)
        self.addSubview(self.ratingView!)
        self.ratingView!.translatesAutoresizingMaskIntoConstraints = false
        self.ratingView!.topAnchor.constraint(equalTo: self.isOpenLabel.bottomAnchor, constant: 15).isActive = true
        self.ratingView!.leftAnchor.constraint(equalTo: self.nameLabel.leftAnchor).isActive = true
    }
    
    private func setPriceLevel(_ priceLevel: Int?) {
        guard let priceLevel = priceLevel, let ratingView = self.ratingView else { return }
        let symbol = Locale.current.currencySymbol ?? "$"
        let priceLevelLabel = UILabel()
        priceLevelLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        priceLevelLabel.textColor = UIColor(white: 0.3, alpha: 1.0)
        
        
        if  priceLevel < 2 {
            priceLevelLabel.text = "⋅ \(symbol)"
        } else if priceLevel == 2 || priceLevel == 3 {
            priceLevelLabel.text = "⋅ \(symbol)\(symbol)"
        } else if priceLevel == 2 || priceLevel == 3 {
            priceLevelLabel.text = "⋅ \(symbol)\(symbol)\(symbol)"
        }
        
        self.addSubview(priceLevelLabel)
        priceLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLevelLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor).isActive = true
        priceLevelLabel.leftAnchor.constraint(equalTo: ratingView.rightAnchor).isActive = true
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
