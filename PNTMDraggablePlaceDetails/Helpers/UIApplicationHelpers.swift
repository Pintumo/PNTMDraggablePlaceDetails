import UIKit

extension UIApplication {
    static func open(_ string: String) {
        let trimmedString = string.removeWhiteSpaces()
        
        if trimmedString.isURL, let url = URL(string: trimmedString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        
        if trimmedString.isPhoneNumber, let url = URL(string: "tel://\(trimmedString)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url) 
        }
    }
}
