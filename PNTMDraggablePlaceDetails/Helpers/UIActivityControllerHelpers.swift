import UIKit

extension UIActivityViewController {
    static func sharePlacesURL(_ url: URL, presenter: UIViewController) {
        var activities: [Any] = Constants.sharePlaceIcon == nil ? [] : [Constants.sharePlaceIcon!]
        var text = Constants.sharePlaceMessageHeader == nil ? "\(url)" : "\(Constants.sharePlaceMessageHeader!)\n\n \(url)"
        text = Constants.sharePlaceMessageFooter == nil ? text : "\(text)\n\n \(Constants.sharePlaceMessageFooter!)"
        activities.append(text)
        
        let avc = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        avc.popoverPresentationController?.sourceView = presenter.view
        avc.excludedActivityTypes = [ .airDrop,
                                      .addToReadingList,
                                      .assignToContact,
                                      .markupAsPDF,
                                      .openInIBooks,
                                      .postToVimeo,
                                      .saveToCameraRoll,
                                      .print,
                                      .postToFlickr,
                                      .postToVimeo,
                                      UIActivity.ActivityType(rawValue: "com.apple.reminders.RemindersEditorExtension"),
                                      UIActivity.ActivityType(rawValue: "com.apple.mobilenotes.SharingExtension")]
        presenter.present(avc, animated: true, completion: nil)
    }
}

