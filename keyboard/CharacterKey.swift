import UIKit
import AudioToolbox

class CharacterKey: KeyBase {
    private var character: String
    var hint: String = ""
    weak var popupView: KeyPopup?

    init(character: String) {
        self.character = character
        super.init(frame: .zero)
        configureKey()
        hint = KeyboardLayout.anburLayout.hints[character] ?? ""
        clickFeedback.prepare()
        longPressFeedback.prepare()
    }

    required init?(coder aDecoder: NSCoder) {
        self.character = ""
        super.init(coder: aDecoder)
        configureKey()
    }

    private func configureKey() {
        titleLabel?.font = UIFont.systemFont(ofSize: 22)
        setTitle(character, for: .normal)
        setTitleColor(UIColor.clear, for: .normal)
        addTarget(self, action: #selector(keyTapped), for: .touchUpInside)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawHint(in: rect)
    }
        
    private func drawHint(in rect: CGRect) {
        // Ensure the graphics context is available
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.dynamicHintColor
        ]
        
        let attributedString = NSAttributedString(string: hint, attributes: attributes)
        let stringSize = attributedString.size()
        let stringRect = CGRect(
            x: rect.maxX - stringSize.width - 5 - self.additionalPaddingRight,
            y: rect.minY + 7,
            width: stringSize.width,
            height: stringSize.height
        )
        
        context.saveGState() // Save the current state
        attributedString.draw(in: stringRect)
        context.restoreGState() // Restore the state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        showPopup()
        AudioServicesPlaySystemSound(1123)
        clickFeedback.impactOccurred()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        hidePopup()
        clickFeedback.prepare()
    }

    private func showPopup() {
        if popupView == nil {
            let popup = KeyPopup(key: self)
            addSubview(popup)
            popupView = popup
        }
        popupView?.isHidden = false
    }

    private func hidePopup() {
        popupView?.isHidden = true
    }

    @objc private func keyTapped() {
        delegate?.keyDidTap(character: character)
    }
}

