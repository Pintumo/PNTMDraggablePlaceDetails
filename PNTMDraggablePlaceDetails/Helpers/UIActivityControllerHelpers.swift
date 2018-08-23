import UIKit

extension UIActivityViewController {
    static func sharePlacesURL(_ url: URL, presenter: UIViewController) {
        let avc = UIActivityViewController(activityItems: [ url ], applicationActivities: nil)
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

