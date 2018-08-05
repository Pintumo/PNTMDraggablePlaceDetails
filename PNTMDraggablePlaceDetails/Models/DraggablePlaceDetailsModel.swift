import MapKit

public struct DraggablePlaceDetailsPlaceModel {
    let googlePlaceId: String?
    let name: String?
    let localizedTags: [String]?
    let description: String?
    let address: String?
    let location: CLLocationCoordinate2D?
    let rating: Float?
    let price_level: Int?
    let phone: String?
    let website: String?
    let photos: [String]?
    let open_now: Bool?
    let reviews: [DraggablePlaceDetailsReviewModel]?
    
    public init(googlePlaceId: String? = nil,
                name: String? = nil,
                localizedTags: [String]? = nil,
                description: String? = nil,
                address: String? = nil,
                location: CLLocationCoordinate2D? = nil,
                rating: Float? = nil,
                price_level: Int? = nil,
                phone: String? = nil,
                website: String? = nil,
                photos: [String]? = nil,
                open_now: Bool? = nil,
                reviews: [DraggablePlaceDetailsReviewModel]? = nil) {
        self.googlePlaceId = googlePlaceId
        self.name = name
        self.localizedTags = localizedTags
        self.description = description
        self.address = address
        self.location = location
        self.rating = rating
        self.price_level = price_level
        self.phone = phone
        self.website = website
        self.photos = photos
        self.open_now = open_now
        self.reviews = reviews
    }
    
    
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

public struct DraggablePlaceDetailsReviewModel {
    let author: String?
    let profile_photo_url: String?
    let rating: Int?
    let text: String?
    let relative_time_description: String?
    
    public init(author: String? = nil,
                profile_photo_url: String? = nil,
                rating: Int? = nil,
                text: String? = nil,
                relative_time_description: String? = nil) {
        self.author = author
        self.profile_photo_url = profile_photo_url
        self.rating = rating
        self.text = text
        self.relative_time_description = relative_time_description
    }
}
