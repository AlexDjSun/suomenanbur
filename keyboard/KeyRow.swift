import UIKit

class KeyRow: UIView {
    weak var delegate: KeyDelegate?
    private var keys: [KeyBase] = []
    private let specialKeysLabels: Set<String> = ["⌫", "⇧", "123", "globe", "space", "return", "ABC", "#+=", "backspace", "shift"]
    private let biggestRowLength: Int

    init(keys: [String], delegate: KeyDelegate?, biggestRowLength: Int) {
        self.delegate = delegate
        self.biggestRowLength = biggestRowLength
        super.init(frame: .zero)
        
        self.keys = keys.map { keyLabel in
            specialKeysLabels.contains(keyLabel) ? SpecialKey(keyLabel: keyLabel) : CharacterKey(character: keyLabel)
        }
        setupRow()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupRow() {
        let standardMultiplier = 1.0 / CGFloat(biggestRowLength)
        let needToPutInvisibleKeys = (8..<biggestRowLength).contains(keys.count)

        keys.forEach { key in
            addSubview(key)
            key.delegate = delegate
            key.translatesAutoresizingMaskIntoConstraints = false
            
            setupKeyConstraints(key: key, standardMultiplier: standardMultiplier)
        }
    }

    private func setupKeyConstraints(key: KeyBase, standardMultiplier: CGFloat) {
        key.topAnchor.constraint(equalTo: topAnchor).isActive = true
        key.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        if let index = keys.firstIndex(of: key) {
            let leadingAnchor = index == 0 ? self.leadingAnchor : keys[index - 1].trailingAnchor
            key.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

            if index == keys.count - 1 {
               key.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            } else {
                let multiplier = calculateMultiplierForKey(key: key, isSpaceRow: keys.contains { ($0 as? SpecialKey)?.titleLabel?.text == "space" }, standardMultiplier: standardMultiplier)
                key.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier).isActive = true
            }
        }
    }
    
    private func calculateMultiplierForKey(key: KeyBase, isSpaceRow: Bool, standardMultiplier: CGFloat) -> CGFloat {
        let specialKeysCount = keys.filter { $0 is SpecialKey }.count
        let characterKeysCount = keys.filter { $0 is CharacterKey }.count
        if isSpaceRow, key.titleLabel?.text == "space" {
            return standardMultiplier * (CGFloat(biggestRowLength) * 0.5 - CGFloat(characterKeysCount))
        } else if !isSpaceRow, keys.count <= 7 {
            return 1.0 / CGFloat(keys.count)
        } else if key is SpecialKey {
            return standardMultiplier * 1.25
        } else {
            return standardMultiplier
        }
    }
}
