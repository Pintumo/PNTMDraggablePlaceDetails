import UIKit

public struct Constants {
    public static var mainColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
    public static var secondaryColor = #colorLiteral(red: 0.2862745098, green: 0.4862745098, blue: 0.8117647059, alpha: 1)
    public static var buttonBackgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    
    public static var headerFont = UIFont.systemFont(ofSize: 24, weight: .light)
    public static var subLabelFont = UIFont.systemFont(ofSize: 12)
    public static var contactCellFont = UIFont.systemFont(ofSize: 14)
    
    public static var reviewHeaderFont = UIFont.systemFont(ofSize: 18, weight: .light)
    public static var reviewerNameLabel = UIFont.systemFont(ofSize: 14, weight: .light)
    
    public static var sharePlaceIcon: UIImage?
    public static var sharePlaceMessageHeader: String?
    public static var sharePlaceMessageFooter: String?
    
    public static var cellInset: CGFloat = 15.0
    
    internal static let DPDImageReuseIdentifier = "DraggablePlaceDetailsImageReuseIdentifier"
    internal static let DPDReviewReuseIdentifier = "DraggablePlaceDetailsReviewReuseIdentifier"
    
}
