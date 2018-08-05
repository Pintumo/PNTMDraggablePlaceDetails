import Foundation

enum Localizable: String {
    
    case cancel
    
    case shareLocation
    case routeWith
    
    case open
    case closed
    
    case opensAt
    case closesAt

    case reviews
    
    func loc() -> String {
        let bundle = Bundle(for: DraggablePlaceDetailsViewController.self)
        return NSLocalizedString(self.rawValue, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
