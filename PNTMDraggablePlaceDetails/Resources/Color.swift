import UIKit


enum Color: String {

    case stars_y_1
    case stars_y_2
    case stars_y_3
    case stars_y_4
    case stars_y_5
    
    func set() -> UIColor {
        return UIColor(named: "color_\(self.rawValue)")!
    }
}
