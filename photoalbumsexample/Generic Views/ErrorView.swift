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
        messageLabel.numberOfLines = 0
        addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
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
