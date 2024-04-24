import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let headerView = UIView()
    private let appNameLabel = UILabel()
    private let linksStackView = UIStackView()
    
    private let contentView = UIView()
    private var textField: TextField!

    private let textKey = "com.majbyr.suomenanbur.text"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        configureBackgroundColor()
        configureHeaderView()
        configureTextField()
        configureContentView()
        configureLinksStackView()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemGray6
    }
    
    private func configureHeaderView() {
        headerView.backgroundColor = .systemGray5
        view.addSubview(headerView)
        
        appNameLabel.text = "𐍡𐍣𐍩𐍜𐍔𐍝 𐍐𐍝𐍑𐍣𐍠"
//        appNameLabel.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        appNameLabel.font = .preferredFont(forTextStyle: .title3)
        appNameLabel.textAlignment = .center
        headerView.addSubview(appNameLabel)
        
    }
    
    private func configureTextField() {
            textField = TextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(textField)
            
            // Additional configuration if needed
            textField.delegate = self  // Make sure to conform ViewController to UITextFieldDelegate if you use this
        }
    
    private func configureContentView() {
        view.addSubview(contentView)
        
    }
    
    private func configureLinksStackView() {
        linksStackView.configureAsVerticalStack(withSpacing: 16)
        view.addSubview(linksStackView)
        
        let buttons = [
            ("settings", "Settings", #selector(openSettings)),
            ("app.store", "App Store", #selector(openAppStore)),
            ("github", "GitHub", #selector(openGitHub)),
            ("globe", "Website", #selector(openWebsite))        ]
        
        buttons.forEach { imageName, title, selector in
            let button = UIButton.createSystemButton(withTitle: title, imageSystemName: imageName, target: self, action: selector)
            button.contentHorizontalAlignment = .left
            linksStackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        // Deactivate translatesAutoresizingMaskIntoConstraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        linksStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header View Constraints
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            appNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // Content View Constraints
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            linksStackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            linksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            linksStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ])
    }
    
    @objc private func openSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    // Implement these methods to handle opening URLs
    @objc private func openAppStore() {}
    @objc private func openGitHub() {}
    @objc private func openWebsite() {}
}

// MARK: Extension for UIButton Configuration

extension UIButton {
    static func createSystemButton(withTitle title: String, imageSystemName imageName: String, target: Any?, action: Selector) -> UIButton {
        let button = UIButton(type: .custom)

        // Setup image on the left
        if let originalImage = UIImage(named: imageName) {
            let resizedImage = originalImage.resized(to: CGSize(width: 30, height: 30))
            button.setImage(resizedImage, for: .normal)
            button.tintColor = .label
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0) // Adjust as needed
        }
        
        let arrowImage = UIImage(systemName: "chevron.right")

        button.setTitle(title, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10) // Adjust as needed

        // General styling
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(target, action: action, for: .touchUpInside)

        return button
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

// MARK: Extension for UIStackView Configuration

extension UIStackView {
    func configureAsVerticalStack(withSpacing spacing: CGFloat) {
//        self.backgroundColor = .green
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = spacing
    }
}
