import UIKit

class TableView: UITableView {
    override var contentOffset: CGPoint {
        didSet {
            super.contentOffset = contentOffset
        }
    }
}
