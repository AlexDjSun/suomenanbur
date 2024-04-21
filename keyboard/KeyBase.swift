import UIKit
import AudioToolbox

protocol KeyDelegate: AnyObject {
    func keyDidTap(character: String)
    func handleLongPress()
}

class KeyBase: UIButton {
    weak var delegate: KeyDelegate?
    let basePadding: CGFloat = 3.3
    var fontSize: CGFloat = 22
    var additionalPaddingLeft: CGFloat = 0
    var additionalPaddingRight: CGFloat = 0
    
    let clickFeedback = UIImpactFeedbackGenerator(style: .light)
    let longPressFeedback = UIImpactFeedbackGenerator(style: .heavy)

    var keyColor: UIColor = .dynamicKeyColor
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.saveGState()
        let adjustedRect = rect.adjustedForPadding(left: additionalPaddingLeft, right: additionalPaddingRight, basePadding: basePadding)
        drawRoundedRectangle(in: adjustedRect, context: context)
        context.restoreGState()
        drawKeyTitle(in: adjustedRect)
    }

    private func drawRoundedRectangle(in rect: CGRect, context: CGContext) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 5)
        configureShadow(in: context)
        context.addPath(path.cgPath)
        context.setFillColor(keyColor.cgColor)
        context.fillPath()
    }

    private func drawKeyTitle(in rect: CGRect) {
        guard let title = title(for: .normal) else { return }

        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
            NSAttributedString.Key.foregroundColor: UIColor.dynamicTextColor
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        let stringSize = attributedString.size()
        let stringRect = CGRect(
            x: rect.midX - stringSize.width / 2,
            y: rect.midY - stringSize.height / 2,
            width: stringSize.width,
            height: stringSize.height
        )
        attributedString.draw(in: stringRect)
    }
    
    private func configureShadow(in context: CGContext) {
        context.setShadow(offset: CGSize(width: 0, height: 1), blur: 0.1, color: UIColor.dynamicShadowColor.cgColor)
    }
}

private extension CGRect {
    func adjustedForPadding(left: CGFloat, right: CGFloat, basePadding: CGFloat) -> CGRect {
        let adjustedWidth = self.width - (left + right)
        let adjustedOriginX = self.origin.x + left
        return CGRect(x: adjustedOriginX, y: self.origin.y, width: adjustedWidth, height: self.height).insetBy(dx: basePadding, dy: basePadding * 2)
    }
}

