import UIKit

struct DraggablePlaceDetailsStore {
    
    enum cellType: Int, CaseIterable {
        case header
        case address
        case openingHours
        case phone
        case website
    }

    var mainColor = UIColor.blue
    var secondaryColor = UIColor.white
    var textColor = UIColor(white: 0.4, alpha: 1.0)
    var lightTextColor = UIColor(white: 0.2, alpha: 1.0)
    
    var routeButtonImage: UIImage?
    var shareButtonImage: UIImage?
    var addressLabelImage: UIImage? = nil
    var openingHoursLabelImage: UIImage? = nil
    var phoneLabelImage: UIImage? = nil
    var websiteLabelImage: UIImage? = nil
    
    var lineSpacing: CGFloat = 6
    
    var model: DraggablePlaceDetailsPlaceModel
    
    init(model: DraggablePlaceDetailsPlaceModel) {
        self.model = model
    }
    
    
    func numbersOfRowsInSection(_ section: Int) -> Int {
        return section == 0 ? cellType.allCases.count : model.reviews?.count ?? 0
    }
    
    func numberOfPhotos() -> Int {
        return model.photos?.count ?? 1
    }
    
    func heightAtIndexPath(_ indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 181
        }
        else if indexPath.section == 0 {
            return 74
        }
        else {
            guard let reviews = self.model.reviews, let text = reviews[indexPath.row].text else { return 0.0 }
            return text.height(withWidth: UIScreen.main.bounds.width - Constants.cellInset * 2, font: UIFont.systemFont(ofSize: 12, weight: .light), spacing: lineSpacing) + 60
        }
    }
    
    func photoAtIndexPath(_ indexPath: IndexPath) -> URL? {
        guard let url = self.model.photos?[indexPath.row] else { return nil }
        return URL(string: url)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath,
                   target: UIViewController,
                   shareAction: Selector,
                   routeAction: Selector) -> UITableViewCell {
        if indexPath.section == 0, let type = cellType(rawValue: indexPath.row) {
            let cell = cellForType(type,
                                   target: target,
                                   shareAction: shareAction,
                                   routeAction: routeAction)
            return cell
        } else {
            let cell = self.tableView(tableView, dequeCellForReviewAt: indexPath)
            guard let reviews = self.model.reviews else { return UITableViewCell() }
            let review = reviews[indexPath.row]
            cell.nameLabel.textColor = self.textColor
            cell.nameLabel.text = review.author
            cell.reviewLabel.textColor = self.lightTextColor
            cell.reviewLabel.setText(review.text ?? "", spacing: lineSpacing)
            if let rating = review.rating { cell.rating = Float(rating) }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0,
            let type = cellType(rawValue: indexPath.row),
            let string = titleForType(type) else {
                return
        }
        
        UIApplication.open(string)
    }
    
    func tableView(_ tableView: UITableView, dequeCellForReviewAt indexPath: IndexPath) -> ReviewCell {
        return tableView
            .dequeueReusableCell(withIdentifier: Constants.DPDReviewReuseIdentifier, for: indexPath)
            as! ReviewCell
    }
    
    func cellForType(_ type: cellType,
                     target: UIViewController,
                     shareAction: Selector,
                     routeAction: Selector) -> UITableViewCell {
        if type == .header {
            return headerCell(target: target, shareAction: shareAction, routeAction: routeAction)
        } else {
            return contactCellForType(type, mainColor: mainColor)
        }
    }
    
    func headerCell(target: UIViewController,
                    shareAction: Selector,
                    routeAction: Selector) -> UITableViewCell {
        let cell = HeaderCell(mainColor: mainColor)
        cell.shareButton.setImage(self.shareButtonImage, for: .normal)
        cell.shareButton.addTarget(target, action: shareAction, for: .touchUpInside)
        cell.routeButton.setImage(self.routeButtonImage, for: .normal)
        cell.routeButton.addTarget(target, action: routeAction, for: .touchUpInside)
        cell.name = self.titleForType(.header)
        cell.tags = model.localizedTags
        cell.isOpen = model.open_now
        cell.rating = model.rating
        cell.priceLevel = model.price_level
        return cell
    }
    
    func contactCellForType(_ type: cellType, mainColor: UIColor) -> UITableViewCell {
        let contactIndex = type.rawValue - 1
        guard let cell = ContactCell(index: contactIndex,
                                     text: self.titleForType(type),
                                     image: self.iconForType(type),
                                     mainColor: self.mainColor,
                                     font: Constants.contactCellFont) else { return UITableViewCell() }
        return cell
    }
    
    func titleForType(_ type: cellType) -> String? {
        switch type {
        case .header: return model.name
        case .address: return model.address
        case .openingHours: return openingHoursTitle() ?? "---"
        case .phone: return model.phone
        case .website: return model.website
        }
    }
    
    func iconForType(_ type: cellType) -> UIImage? {
        switch type {
        case .header: return nil
        case .address: return self.addressLabelImage
        case .openingHours: return self.openingHoursLabelImage
        case .phone: return self.phoneLabelImage
        case .website: return self.websiteLabelImage
        }
    }
    
    func openingHoursTitle() -> String? {
        let closesAt = closesAtPeriod()
        let opensAt = opensAtPeriod(closingAt: closesAt)
        return titleFrom(openPeriod: opensAt, closePeriod: closesAt)
    }
    
    func closesAtPeriod() -> DraggablePlaceDetailsOpenHoursModel? {
        let date = Date()
        let components = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date)
        let today = components.weekday! - 1
        let currentHour = components.hour!
        return self.model.open_periods?.filter { period in
            guard let o = period.openHours, let oHour = o.hour, let c = period.closeHours, let cHour = c.hour,
                (o.day == today && currentHour > oHour && (c.day != today || (c.day == today && currentHour < cHour)))
                    || (o.day != today && c.day == today && currentHour < cHour) else {
                        return false
            }
            return true
            }.first
    }
    
    func opensAtPeriod(closingAt: DraggablePlaceDetailsOpenHoursModel?) -> DraggablePlaceDetailsOpenHoursModel? {
        let date = Date()
        let components = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date)
        let today = components.weekday! - 1
        let currentHour = components.hour!
        return model.open_periods?.filter { period in
            guard let o = period.openHours, let oHour = o.hour,
                o.day == today && currentHour < oHour
                    || o.day == (today + 1)%7 && closingAt == nil else {
                        return false
            }
            return true
            }.first
    }
    
    func titleFrom(openPeriod: DraggablePlaceDetailsOpenHoursModel?,
                   closePeriod: DraggablePlaceDetailsOpenHoursModel?) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        if let closesAt = closePeriod,  let date = calendar.date(from: closesAt.closeHours!) {
            let time = dateFormatter.string(from: date)
            return "\(Localizable.closesAt.loc()) \(time)"
        } else if let opensAt = openPeriod, let date = calendar.date(from: opensAt.openHours!) {
            let time = dateFormatter.string(from: date)
            return "\(Localizable.opensAt.loc()) \(time)"
        }  else {
            return "---"
        }
    }
}
