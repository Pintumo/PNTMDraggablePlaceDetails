import UIKit

extension UILabel {
    func setText(_ text: String, spacing: CGFloat) {
        let attr = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.alignment = self.textAlignment
        style.lineSpacing = spacing
        attr.addAttribute(.paragraphStyle,
                          value: style,
                          range: NSMakeRange(0, attr.length))
        self.attributedText = attr;
    }
}
