import UIKit
import AudioToolbox

class SpecialKey: KeyBase {
    private var keyLabel: String
    private var longPressTimer: Timer?
    
    init(keyLabel: String) {
        self.keyLabel = keyLabel
        super.init(frame: .zero)
        configureKey()
        clickFeedback.prepare()
        longPressFeedback.prepare()
    }

    required init?(coder aDecoder: NSCoder) {
        self.keyLabel = ""
        super.init(coder: aDecoder)
        configureKey()
    }

    private func configureKey() {
        switch keyLabel {
        case "shift":
            self.keyLabel = "⇧"
            self.keyColor = UIColor.dynamicActionKeyColor
            self.fontSize = 22
        case "backspace":
            self.keyLabel = "⌫"
            self.keyColor = UIColor.dynamicActionKeyColor
            self.fontSize = 22
        case "space":
            self.fontSize = 15
        case "⌫", "⇧":
            self.keyColor = UIColor.dynamicActionKeyColor
            self.fontSize = 22
        case "globe":
            self.keyColor = UIColor.dynamicActionKeyColor
            self.imageView?.tintColor = UIColor.dynamicTextColor
            self.setImage(UIImage(named: "globe"), for: .normal)
            if let globeImage = UIImage(named: "globe"),
               let resizedGlobeImage = resizeImage(globeImage, toWidth: 22, andHeight: 22) { // Specify your desired size here
                self.setImage(resizedGlobeImage.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            self.setTitle("", for: .normal)
            self.imageView?.tintColor = UIColor.dynamicTextColor
            self.imageView?.contentMode = .scaleAspectFit
            self.imageEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
        default:
            self.keyColor = UIColor.dynamicActionKeyColor
            self.fontSize = 15
        }
        
        if keyLabel != "globe" {
                setTitle(keyLabel, for: .normal)
        }
        setTitleColor(UIColor.clear, for: .normal)
        addTarget(self, action: #selector(keyTapped), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.keyColor = keyLabel == "space" ? UIColor.dynamicActionKeyColor : UIColor.dynamicKeyColor
        self.setNeedsDisplay()
        
        clickFeedback.impactOccurred()
        AudioServicesPlaySystemSound(1156)
        
        longPressTimer?.invalidate()
        longPressTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(handleLongPress), userInfo: nil, repeats: false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.keyColor = keyLabel == "space" ? UIColor.dynamicKeyColor : UIColor.dynamicActionKeyColor
        self.setNeedsDisplay()
        
        longPressTimer?.invalidate()
        longPressTimer?.prepareForInterfaceBuilder()
        delegate?.stopContinuousDelete()
    }
    
    func resizeImage(_ image: UIImage, toWidth width: CGFloat, andHeight height: CGFloat) -> UIImage? {
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }

    
    @objc private func keyTapped() {
        delegate?.keyDidTap(character: keyLabel)
    }
    
    @objc private func handleLongPress() {
        longPressFeedback.impactOccurred()
        if keyLabel == "⌫" {
            delegate?.startContinuousDelete()
        }
        delegate?.handleLongPress()
    }
}

