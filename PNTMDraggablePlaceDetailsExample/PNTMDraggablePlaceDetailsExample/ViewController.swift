import PNTMDraggablePlaceDetails
import MapKit

class ViewController: UIViewController {
    
    lazy var review1 = DraggablePlaceDetailsReviewModel(
        author: "Some Author",
        rating: 4,
        text:   """
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                """,
        relative_time_description: nil)
    lazy var review2 = DraggablePlaceDetailsReviewModel(
        author: "Some Author",
        rating: 4,
        text:   """
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
                """,
        relative_time_description: nil)
    lazy var review3 = DraggablePlaceDetailsReviewModel(
        author: "Some Author",
        rating: 4,
        text:   """
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                """,
        relative_time_description: nil)
    lazy var model = DraggablePlaceDetailsPlaceModel(
        googlePlaceId: nil,
        name: "Some Restaurant",
        localizedTags: ["Cafe", "Restaurant", "Bar"],
        description: "Some Description",
        address: "Some Address in some City in some Country",
        location: CLLocationCoordinate2D(latitude: 52.0, longitude: 13.0),
        rating: 4.2,
        phone: "+XX XXX XXXXXXXXXX",
        website: "http://pintumo.com",
        photos: ["https://bit.ly/2LJnvKx", "https://bit.ly/2A8OopF", "https://bit.ly/2NLa8Kq", "https://bit.ly/2LJnvKx", "https://bit.ly/2A8OopF", "https://bit.ly/2NLa8Kq", "https://bit.ly/2LJnvKx", "https://bit.ly/2A8OopF"],
        open_now: true,
        reviews: [review1, review2, review3])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .system)
        button.setTitle("Show Place Details", for: .normal)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.addTarget(self, action: #selector(didTapButtonForDetails), for: .touchUpInside)
    }
}

extension ViewController {
    @objc func didTapButtonForDetails() {
        let vc = DraggablePlaceDetailsViewController(model)
        self.present(vc, animated: true, completion: nil)
    }
}

