import PNTMDraggablePlaceDetails
import MapKit

class ViewController: UIViewController {
    
    static var day0 = DraggablePlaceDetailsOpenHoursModel(openHours: DateComponents(day: 0, hour: 8, minute: 0),
                                                          closeHours: DateComponents(day: 1, hour: 1, minute: 00))
    static var day1 = DraggablePlaceDetailsOpenHoursModel(openHours: DateComponents(day: 1, hour: 8, minute: 00),
                                                          closeHours: DateComponents(day: 2, hour: 1, minute: 00))
    static var day2 = DraggablePlaceDetailsOpenHoursModel(openHours: DateComponents(day: 2, hour: 8, minute: 30),
                                                          closeHours: DateComponents(day: 3, hour: 1, minute: 00))
    static var day3 = DraggablePlaceDetailsOpenHoursModel(openHours: DateComponents(day: 3, hour: 8, minute: 30),
                                                          closeHours: DateComponents(day: 4, hour: 1, minute: 00))
    static var day4 = DraggablePlaceDetailsOpenHoursModel(openHours: DateComponents(day: 4, hour: 8, minute: 30),
                                                          closeHours: DateComponents(day: 5, hour: 1, minute: 00))
    static var day5 = DraggablePlaceDetailsOpenHoursModel(openHours: DateComponents(day: 5, hour: 8, minute: 30),
                                                          closeHours: DateComponents(day: 6, hour: 1, minute: 00))
    static var day6 = DraggablePlaceDetailsOpenHoursModel(openHours: DateComponents(day: 6, hour: 8, minute: 30),
                                                          closeHours: DateComponents(day: 6, hour: 19, minute: 00))
    
    static var review1 = DraggablePlaceDetailsReviewModel(
        author: "Some Author",
        rating: 4,
        text:   """
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                """,
        relative_time_description: nil)
    static var review2 = DraggablePlaceDetailsReviewModel(
        author: "Some Author",
        rating: 4,
        text:   """
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
                """,
        relative_time_description: nil)
    static var review3 = DraggablePlaceDetailsReviewModel(
        author: "Some Author",
        rating: 4,
        text:   """
                Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                """,
        relative_time_description: nil)
    
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
        let model = ViewController.createModelWithReviews(false)
        let vc = DraggablePlaceDetailsViewController(model)
        Constants.dismissIcon = UIImage(named: "icon_dismiss")
        Constants.mainColor = .red
        Constants.textColor = .brown
        Constants.lightTextColor = .gray
        self.present(vc, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let newModel = ViewController.createModelWithReviews(true)
            vc.updatedModel(newModel)
        }
    }
}

extension ViewController {
    static func createModelWithReviews(_ withReviews: Bool) -> DraggablePlaceDetailsPlaceModel {
        return DraggablePlaceDetailsPlaceModel(
            googlePlaceId: nil,
            name: "Some Restaurant",
            localizedTags: ["Cafe", "Restaurant", "Bar"],
            description: "Some Description",
            address: "Some Address in some City in some Country",
            location: CLLocationCoordinate2D(latitude: 52.0, longitude: 13.0),
            rating: 4.2,
            price_level: 3,
            phone: "+XX XXX XXXXXXXXXX",
            website: "http://pintumo.com",
            photos:  withReviews ? ["https://bit.ly/2A8OopF", "https://bit.ly/2NLa8Kq", "https://bit.ly/2LJnvKx", "https://bit.ly/2A8OopF", "https://bit.ly/2NLa8Kq", "https://bit.ly/2LJnvKx", "https://bit.ly/2A8OopF"] : ["https://bit.ly/2A8OopF"],
            open_now: true,
            open_periods: [day0, day1, day2, day3, day4, day5, day6],
            reviews: withReviews ? [review1] : nil)
    }
}
