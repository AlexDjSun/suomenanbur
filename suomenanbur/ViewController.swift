import UIKit

class ViewController: UIViewController {
    
    private let headerView = UIView()
    private let appNameLabel = UILabel()
    private let settingsButton = UIButton(type: .system)
    private let linksStackView = UIStackView()
    
    private let contentView = UIView()
    private let textView = TextFieldViewController().textField
    private let appearanceSwitch = UISwitch()
    private let appearanceSwitchLabel = UILabel()
    
    private let textKey = "com.majbyr.suomenanbur.text"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        setupViews()
        setupConstraints()
        setupInteractions()
    }
    
    private func setupViews() {
        configureBackgroundColor()
        configureHeaderView()
        configureContentView()
        configureLinksStackView()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureHeaderView() {
        headerView.backgroundColor = .systemGray5
        view.addSubview(headerView)
        
        appNameLabel.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
        appNameLabel.font = .preferredFont(forTextStyle: .title2)
        headerView.addSubview(appNameLabel)
        
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        headerView.addSubview(settingsButton)
    }
    
    private func configureContentView() {
        view.addSubview(contentView)
        
        let normalFont: UIFont = .systemFont(ofSize: 17, weight: .regular)
        textView.borderStyle = .roundedRect
        textView.font = normalFont
        textView.placeholder = "Enter some text"
        textView.text = UserDefaults.standard.string(forKey: textKey)
        
        contentView.addSubview(textView)
        
        appearanceSwitch.addTarget(self, action: #selector(appearanceSwitchValueChanged), for: .valueChanged)
        contentView.addSubview(appearanceSwitch)
        
        appearanceSwitchLabel.text = "Dark Appearance"
        contentView.addSubview(appearanceSwitchLabel)
    }
    
    private func configureLinksStackView() {
        linksStackView.configureAsVerticalStack(withSpacing: 16)
        view.addSubview(linksStackView)
        
        let buttons = [
            ("app.store", "App Store", #selector(openAppStore)),
            ("github", "GitHub", #selector(openGitHub)),
            ("globe", "Website", #selector(openWebsite))
        ]
        
        buttons.forEach { imageName, title, selector in
            let button = UIButton.createSystemButton(withTitle: title, imageSystemName: imageName, target: self, action: selector)
            linksStackView.addArrangedSubview(button)
        }
    }
    
    private func setupConstraints() {
        // Deactivate translatesAutoresizingMaskIntoConstraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        appearanceSwitch.translatesAutoresizingMaskIntoConstraints = false
        appearanceSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        linksStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header View Constraints
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            appNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            appNameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            
            settingsButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            
            // Content View Constraints
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            appearanceSwitch.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            appearanceSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            appearanceSwitchLabel.centerYAnchor.constraint(equalTo: appearanceSwitch.centerYAnchor),
            appearanceSwitchLabel.leadingAnchor.constraint(equalTo: appearanceSwitch.trailingAnchor, constant: 8),
            
            linksStackView.topAnchor.constraint(equalTo: appearanceSwitch.bottomAnchor, constant: 16),
            linksStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
        ])
    }

    
    private func setupInteractions() {
        textView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textViewTapped)))
    }
    
    // MARK: Selector Methods
    
    @objc private func textViewTapped() {
        textView.becomeFirstResponder()
    }
    
    @objc private func appearanceSwitchValueChanged(_ sender: UISwitch) {
        view.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
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
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
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
