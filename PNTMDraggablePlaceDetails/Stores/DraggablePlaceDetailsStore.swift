import UIKit

struct DraggablePlaceDetailsStore {
    
    enum cellType: Int, CaseIterable {
        case header
        case address
        case phone
        case website
    }
    
    var model: DraggablePlaceDetailsPlaceModel
    
    func numbersOfRowsInSection(_ section: Int) -> Int {
        return section == 0 ? cellType.allCases.count : model.reviews?.count ?? 0
    }
    
    func numberOfPhotos() -> Int {
        return model.photos?.count ?? 0
    }
    
    func heightAtIndexPath(_ indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 150
        }
        else if indexPath.section == 0 {
            return 74
        }
        else {
            guard let reviews = self.model.reviews, let text = reviews[indexPath.row].text else { return 0.0 }
            return text.height(withWidth: UIScreen.main.bounds.width - Constants.cellInset * 2, font: UIFont.systemFont(ofSize: 14)) + 60
        }
    }
    
    func photoAtIndexPath(_ indexPath: IndexPath) -> URL? {
        guard let url = self.model.photos?[indexPath.row] else { return nil }
        return URL(string: url)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, target: UIViewController, shareAction: Selector, routeAction: Selector) -> UITableViewCell {
        if indexPath.section == 0, let type = cellType(rawValue: indexPath.row) {
            let cell = cellForType(type, target: target, shareAction: shareAction, routeAction: routeAction)
            return cell
        } else {
            let cell = self.tableView(tableView, dequeCellForReviewAt: indexPath)
            guard let reviews = self.model.reviews else { return UITableViewCell() }
            let review = reviews[indexPath.row]
            cell.name = review.author ?? "-"
            cell.review = review.text ?? "-"
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
    
    func cellForType(_ type: cellType, target: UIViewController, shareAction: Selector, routeAction: Selector) -> UITableViewCell {
        if type == .header {
            return headerCell(target: target, shareAction: shareAction, routeAction: routeAction)
        } else {
            return contactCellForType(type)
        }
    }

    func headerCell(target: UIViewController, shareAction: Selector, routeAction: Selector) -> UITableViewCell {
        let cell = HeaderCell()
        cell.shareButton.addTarget(target, action: shareAction, for: .touchUpInside)
        cell.routeButton.addTarget(target, action: routeAction, for: .touchUpInside)
        cell.name = self.titleForType(.header)
        cell.tags = model.localizedTags
        cell.isOpen = model.open_now
        cell.rating = model.rating
        return cell
    }
    
    func contactCellForType(_ type: cellType) -> UITableViewCell {
        let contactIndex = type.rawValue - 1
        guard let cell = ContactCell(index: contactIndex, text: self.titleForType(type)) else { return UITableViewCell() }
        return cell
    }
    
    func titleForType(_ type: cellType) -> String? {
        switch type {
        case .header: return model.name
        case .address: return model.address
        case .phone: return model.phone
        case .website: return model.website
        }
    }
}
