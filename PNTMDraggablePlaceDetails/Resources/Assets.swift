import UIKit

enum Assets: String {
    case star_empty
    case star_half
    case star_full
    
    func image() -> UIImage? {
        let bundle = Bundle(for: DraggablePlaceDetailsViewController.self)
        return UIImage(named: self.rawValue, in: bundle, compatibleWith: nil)
    }
}
