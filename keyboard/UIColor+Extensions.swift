import UIKit

extension UIColor {
    static let lightActionButton: UIColor = UIColor(displayP3Red: 179.0 / 255, green: 182.0 / 255, blue: 194.0 / 255, alpha: 1)
    static let darkButton       : UIColor = UIColor(displayP3Red: 107.0 / 255, green: 107.0 / 255, blue: 107.0 / 255, alpha: 1)
    static let darkActionButton : UIColor = UIColor(displayP3Red: 70.0 / 255, green: 70.0 / 255, blue: 70.0 / 255, alpha: 1)
    
    static let dynamicKeyColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .darkButton : .white
    }
    static let dynamicActionKeyColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .darkActionButton : .lightActionButton
    }
    static let dynamicTextColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .white : .black
    }
    static let dynamicShadowColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .black : .gray
    }
    static let dynamicHintColor = UIColor { traitCollection in
        return traitCollection.userInterfaceStyle == .dark ? .lightGray : .gray
    }
}
