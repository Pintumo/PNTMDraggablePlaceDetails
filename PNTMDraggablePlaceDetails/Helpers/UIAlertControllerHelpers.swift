import MapKit
import UIKit

extension UIAlertController {
    static func routeToLocation(_ location: CLLocationCoordinate2D, presenter: UIViewController) {
        let alert = UIAlertController(title: Localizable.routeWith.loc(), message: nil, preferredStyle: .actionSheet)
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
        {
            alert.addAction(UIAlertAction(title: "Google Maps", style: .default) { _ in
                routeWithGoogleMapsToLocation(location)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Apple Maps", style: .default) { _ in
            routeWithAppleMapsToLocation(location)
        })
        
        alert.addAction(UIAlertAction(title: Localizable.cancel.loc(), style: .default) { _ in
            return
        })
        
        presenter.present(alert, animated: true, completion:nil)
    }
}


extension UIAlertController {
    private static func routeWithAppleMapsToLocation(_ location: CLLocationCoordinate2D) {
        let placemark = MKPlacemark(coordinate: location, addressDictionary: nil)
        let mapitem = MKMapItem(placemark: placemark)
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault]
        mapitem.openInMaps(launchOptions: options)
    }
    
    private static func routeWithGoogleMapsToLocation(_ location: CLLocationCoordinate2D) {
        let url = URL(string: "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude))")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
