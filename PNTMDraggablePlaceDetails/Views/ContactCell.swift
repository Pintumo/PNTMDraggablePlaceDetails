import UIKit

class ContactCell: UITableViewCell {
    init?(index: Int, text: String?, image: UIImage?, mainColor: UIColor, font: UIFont) {
        super.init(style: .default, reuseIdentifier: nil)
        super.imageView?.image = image
        super.textLabel?.numberOfLines = 1
        super.textLabel?.lineBreakMode = .byTruncatingMiddle
        super.textLabel?.text = text
        super.textLabel?.font = font
        super.textLabel?.textColor = UIColor(white: 0.4, alpha: 1.0)
        
        let buttonLine = UIView()
        buttonLine.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        self.addSubview(buttonLine)
        buttonLine.translatesAutoresizingMaskIntoConstraints = false
        buttonLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        buttonLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonLine.leftAnchor.constraint(equalTo: self.leftAnchor,constant: Constants.cellInset).isActive = true
        buttonLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.cellInset).isActive = true
        
        guard let text = text, let url = URL(string: text), UIApplication.shared.canOpenURL(url) else { return }
        
        super.textLabel?.textColor = mainColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
