import UIKit
import AudioToolbox

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var mainKeyboardView: KeyboardView!
    @IBOutlet var punctuationKeyboardView: KeyboardView!
    @IBOutlet var secondaryPunctuationKeyboardView: KeyboardView!
    
    var keyboardHeightConstraint: NSLayoutConstraint?
    
    private var deleteTimer: Timer?

    let keyboarHeight: CGFloat = Calculator.getKeyboardHeight()
    let toolbarHeight: CGFloat = Calculator.getToolbar()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if keyboardHeightConstraint == nil {
            keyboardHeightConstraint = self.view.heightAnchor.constraint(equalToConstant: keyboarHeight + toolbarHeight)
            keyboardHeightConstraint?.isActive = true
        } else {
            keyboardHeightConstraint?.constant = keyboarHeight + toolbarHeight
        }
    }

    private func animateKeyboardViewAppearance(_ keyboardView: KeyboardView) {
        // Start by setting the keyboard view's initial state (e.g., alpha = 0 for fade-in effect)
        keyboardView.alpha = 0
        
        // Ensure the keyboard view is already positioned correctly via constraints
        // Add the keyboard view to the view hierarchy if it's not already added
        if keyboardView.superview == nil {
            self.view.addSubview(keyboardView)
            setupConstraintsForKeyboardView(keyboardView)
        }
        
        // Animate the keyboard view to its final state (e.g., alpha = 1)
        UIView.animate(withDuration: 0.25, animations: {
            keyboardView.alpha = 1
        })
    }

    private func setupConstraintsForKeyboardView(_ keyboardView: KeyboardView) {
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            keyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            // Ensure you have constraints that define the keyboard view's height or top anchor as needed
        ])
        self.view.layoutIfNeeded()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.updateKeyboardLayout(for: size)
        }, completion: { _ in
            // TODO: Add view resizing
            self.updateViewSize()
            self.removeAllSubviews()
            self.initializeKeyboardViews()
        })
    }
    
    private func initializeKeyboardViews() {
        // Assuming you have initializers for your custom keyboard views
        self.mainKeyboardView = KeyboardView(rows: KeyboardLayout.anburLayout.keys, delegate: self)
        self.punctuationKeyboardView = KeyboardView(rows: KeyboardLayout.punctuationLayout.keys, delegate: self)
        self.secondaryPunctuationKeyboardView = KeyboardView(rows: KeyboardLayout.secondaryPunctuationLayout.keys, delegate: self)
        
        // Add the initial keyboard view as a subview
        self.view.addSubview(self.mainKeyboardView)
        setupConstraintsForCurrentKeyboardView()
    }
    
    private func setupConstraintsForCurrentKeyboardView() {
        // Assuming mainKeyboardView is the current view; adjust as needed for your setup
        self.mainKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mainKeyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.mainKeyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.mainKeyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            // Add any other constraints necessary for positioning and sizing your keyboard view
        ])
    }
    
    private func removeAllSubviews() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func updateKeyboardLayout(for size: CGSize) {
        self.view.setNeedsDisplay()
        updateSubviews(view: self.view)
    }
    
    private func updateSubviews(view: UIView) {
        view.setNeedsDisplay()
        view.subviews.forEach {
            if $0 is KeyPopup {
                $0.removeFromSuperview()
            } else {
                updateSubviews(view: $0)
            }
        }
    }
    
    private func updateViewSize() {
        keyboardHeightConstraint?.constant = Calculator.getKeyboardHeight() + Calculator.getToolbar()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainKeyboardView = KeyboardView(rows: KeyboardLayout.anburLayout.keys, delegate: self)
        self.punctuationKeyboardView = KeyboardView(rows: KeyboardLayout.punctuationLayout.keys, delegate: self)
        self.secondaryPunctuationKeyboardView = KeyboardView(rows: KeyboardLayout.secondaryPunctuationLayout.keys, delegate: self)
        
        self.view.addSubview(self.mainKeyboardView)
        
        mainKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mainKeyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.mainKeyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.mainKeyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func switchToPunctuationKeyboard() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        self.view.addSubview(self.punctuationKeyboardView)
        
        punctuationKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.punctuationKeyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.punctuationKeyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.punctuationKeyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func switchToSecondaryPunctuationKeyboard() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        self.view.addSubview(self.secondaryPunctuationKeyboardView)
        
        secondaryPunctuationKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.secondaryPunctuationKeyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.secondaryPunctuationKeyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.secondaryPunctuationKeyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func switchToMainKeyboard() {
        self.view.subviews.forEach { $0.removeFromSuperview() }
        self.view.addSubview(self.mainKeyboardView)
        
        mainKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.mainKeyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.mainKeyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.mainKeyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

extension KeyboardViewController: KeyDelegate {
    func startContinuousDelete() {
        deleteTimer?.invalidate()  // Cancel any existing timer
        deleteTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.textDocumentProxy.deleteBackward()
        }
    }

    func stopContinuousDelete() {
        deleteTimer?.invalidate()
        deleteTimer = nil
    }
    
    func keyDidTap(character: String) {
        switch character {
        case "⌫":
            textDocumentProxy.deleteBackward()
        case "space":
            textDocumentProxy.insertText(" ")
        case "return":
            textDocumentProxy.insertText("\n")
        case "globe":
            advanceToNextInputMode()
        case "⇧":
            break
        case "123":
            switchToPunctuationKeyboard()
        case "ABC":
            switchToMainKeyboard()
        case "#+=":
            switchToSecondaryPunctuationKeyboard()
        default:
            textDocumentProxy.insertText(character)
        }
    }
    
    
    
    func handleLongPress() {
        
    }
}


