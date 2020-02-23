import UIKit

class ErrorView: UIView {
    weak var delegate: ErrorViewDelegate?
    private let messageLabel = UILabel()

    init(delegate: ErrorViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.ErrorView.background
        setupMessageLabel()
        setupGestureRecognizer()
    }

    private func setupMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = Colors.ErrorView.message
        messageLabel.text = Constants.ErrorView.message
        messageLabel.font = Constants.ErrorView.font
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.ErrorView.insets.top),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.ErrorView.insets.bottom),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.ErrorView.insets.left),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.ErrorView.insets.right)
        ])
    }

    private func setupGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(errorViewTapped))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        addGestureRecognizer(recognizer)
    }

    @objc
    private func errorViewTapped() {
        delegate?.didTouchErrorView()
    }
}
