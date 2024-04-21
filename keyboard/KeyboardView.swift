import UIKit

class KeyboardView: UIView {

    weak var delegate: KeyDelegate?
    
    private let keyboarHeight: CGFloat = Calculator.getKeyboardHeight()
    
    private var rows: [KeyRow] = []
    
    init(rows: [[String]] = [], delegate: KeyDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        let biggestRowLength = rows.max(by: { $0.count < $1.count })?.count ?? 0
        self.rows = rows.map { KeyRow(keys: $0, delegate: delegate, biggestRowLength: biggestRowLength) }
        setupKeyboardView()
    }
    
    private func setupKeyboardView() {
        var previousRow: UIView?
        for row in rows {
            row.delegate = delegate
            addSubview(row)
            row.translatesAutoresizingMaskIntoConstraints = false

            // Set constraints for each row
            NSLayoutConstraint.activate([
                row.leftAnchor.constraint(equalTo: leftAnchor),
                row.rightAnchor.constraint(equalTo: rightAnchor),
                row.heightAnchor.constraint(equalToConstant: keyboarHeight / CGFloat(rows.count))
            ])

            if let previousRow = previousRow {
                // Position this row below the previous row
                row.topAnchor.constraint(equalTo: previousRow.bottomAnchor).isActive = true
            } else {
                // This is the first row, position it at the top of the keyboard view
                row.topAnchor.constraint(equalTo: topAnchor).isActive = true
            }

            previousRow = row
        }

        // Constraint for the last row to the bottom anchor of the keyboard view
        rows.last?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
