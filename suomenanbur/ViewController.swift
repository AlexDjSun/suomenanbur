import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let headerView = UIView()
    private let appNameLabel = UILabel()
    private let linksStackView = UIStackView()
    
    private let settingsView = UIView()
    
    private let settingsStack = UIStackView()
    
    private let contentView = UIView()
    private var textField: TextField!
        
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
        configureSettingsView()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureHeaderView() {
        view.addSubview(headerView)
        appNameLabel.text = "Suomen Anbur"
        appNameLabel.font = .preferredFont(forTextStyle: .largeTitle).bold()
        appNameLabel.textAlignment = .left
        headerView.addSubview(appNameLabel)
        
    }
    
    private func configureTextField() {
        textField = TextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        textField.delegate = self
    }
    
    private func configureSettingsView() {
        let title = UILabel()
        title.text = "FIRST STEP"
        title.font = .preferredFont(forTextStyle: .caption1)
        title.textColor = .systemGray

        settingsStack.configureAsVerticalStack(withSpacing: 0)
        
        let settingsButton = UIButton.createSystemButton(withTitle: "Open application settings", imageSystemName: "settings", target: self, action: #selector(openSettings))
        settingsStack.addArrangedSubview(settingsButton)
        
        let hint = UILabel()
        hint.text = "Go to Settings > Keyboard > Enable Suomen Anbur"
        hint.font = .preferredFont(forTextStyle: .caption1)
        hint.textColor = .systemGray
        hint.numberOfLines = 0
        
        settingsView.addSubview(title)
        settingsView.addSubview(settingsStack)
        settingsView.addSubview(hint)
        view.addSubview(settingsView)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        hint.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: settingsView.topAnchor),
            title.bottomAnchor.constraint(equalTo: settingsStack.topAnchor, constant: -5),
            title.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 10),
            
            settingsStack.bottomAnchor.constraint(equalTo: hint.topAnchor, constant: -5),
            settingsStack.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor),
            settingsStack.trailingAnchor.constraint(equalTo: settingsView.trailingAnchor),
            
            hint.bottomAnchor.constraint(equalTo: settingsView.bottomAnchor),
            hint.leadingAnchor.constraint(equalTo: settingsView.leadingAnchor, constant: 10)
        ])
    }


    
    private func configureContentView() {
        view.addSubview(contentView)
        
    }
    
    private func configureLinksStackView() {
        linksStackView.configureAsVerticalStack(withSpacing: 0)
        
        view.addSubview(linksStackView)
        
        let buttons = [
            ("app.store", "App Store", #selector(openAppStore)),
            ("github", "GitHub", #selector(openGitHub)),
            ("safari", "Website", #selector(openWebsite))        ]
        
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
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header View Constraints
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            appNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            appNameLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            // Content View Constraints
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            settingsView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            settingsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            linksStackView.topAnchor.constraint(equalTo: settingsView.bottomAnchor, constant: 16),
            linksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            linksStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            
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
        
        // Setup the primary image
        var mainImageView: UIImageView?
        if let originalImage = UIImage(named: imageName)?.resized(to: CGSize(width: 30, height: 30)) {
            mainImageView = UIImageView(image: originalImage)
            mainImageView?.contentMode = .scaleAspectFit
            mainImageView?.translatesAutoresizingMaskIntoConstraints = false
            mainImageView?.widthAnchor.constraint(equalToConstant: 30).isActive = true
            mainImageView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
        
        // Setup the arrow image
        let arrowImage = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let arrowImageView = UIImageView(image: arrowImage)
        arrowImageView.tintColor = .systemGray2
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.widthAnchor.constraint(equalToConstant: 9).isActive = true
        
        // Setup the label
        let label = UILabel()
        label.text = title
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 15)
        
        // Setup stack view containing the images and label
        let stackView = UIStackView(arrangedSubviews: [mainImageView, label, arrowImageView].compactMap { $0 })
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = false
        
        button.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: button.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -10)
        ])
        
        // Setup the underline view
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGray3
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(underlineView)
        
        NSLayoutConstraint.activate([
            underlineView.heightAnchor.constraint(equalToConstant: 0.3),
            underlineView.leadingAnchor.constraint(equalTo: mainImageView!.trailingAnchor, constant: 10),
            underlineView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            underlineView.topAnchor.constraint(equalTo: button.topAnchor, constant: -1)
        ])
        
        // Add target action
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
        self.layer.cornerRadius = 10
        self.backgroundColor = .systemGray6
        self.clipsToBounds = true
        
    }
}

extension UIFont {
    /// Returns a bold version of the preferred font for the specified text style.
    func bold() -> UIFont {
        let descriptor = self.fontDescriptor.withSymbolicTraits(.traitBold) ?? UIFontDescriptor()
        return UIFont(descriptor: descriptor, size: 0)
    }
}
