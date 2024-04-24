import UIKit

class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.placeholder = "Enter some text"
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray.cgColor
        // add padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        
    }
}
