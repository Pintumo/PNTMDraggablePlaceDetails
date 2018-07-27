import MapKit

struct DraggablePlaceDetailsPlaceModel {
    let googlePlaceId: String?
    let name: String?
    let description: String?
    let address: String?
    let location: CLLocationCoordinate2D?
    let rating: Float?
    let phone: String?
    let website: String?
    let photos: [String]?
    let open_now: Bool?
    let reviews: [DraggablePlaceDetailsReviewModel]?
    
    
    
    func sharingURL() -> URL? {
        var string = "https://www.google.com/maps/search/?api=1&query="
        if let name = name {
            string += "\(name)"
        }
        if let location = location {
            string += "\(location.latitude),\(location.longitude)"
        }
        if let address = address {
            string += address
        }
        if let id = googlePlaceId {
            string += "&query_place_id=\(id)"
        }
        
        guard let encodedString = string.encodeUrl() else { return nil }
        
        return URL(string: encodedString)
    }
}

struct DraggablePlaceDetailsReviewModel {
    let author: String?
    let profile_photo_url: String?
    let rating: Int?
    let text: String?
    let relative_time_description: String?
}
