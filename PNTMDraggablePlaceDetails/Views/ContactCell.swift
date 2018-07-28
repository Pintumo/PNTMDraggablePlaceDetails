import UIKit

class ContactCell: UITableViewCell {
    enum type: String, CaseIterable  {
        case address, phone, website
        
        func icon() -> UIImage? {
            let bundle = Bundle(for: DraggablePlaceDetailsViewController.self)
            return UIImage(named: self.rawValue, in: bundle, compatibleWith: nil)
        }
    }
    
    init?(index: Int, text: String?) {
        guard index < ContactCell.type.allCases.count else { return nil }
        let type = ContactCell.type.allCases[index]
        
        super.init(style: .default, reuseIdentifier: nil)
        super.imageView?.image = type.icon()
        super.textLabel?.numberOfLines = 0
        super.textLabel?.textColor = Constants.mainColor
        super.textLabel?.font = UIFont.systemFont(ofSize: 14)
        super.textLabel?.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
