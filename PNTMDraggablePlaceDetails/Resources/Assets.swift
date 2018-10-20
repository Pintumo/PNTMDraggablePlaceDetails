import UIKit

enum Assets: String {
    case star_empty
    case star_half
    case star_full
    
    case star_half_y
    case star_empty_y
    
    func image() -> UIImage? {
        let bundle = Bundle(for: DraggablePlaceDetailsViewController.self)
        return UIImage(named: self.rawValue, in: bundle, compatibleWith: nil)
    }
}
