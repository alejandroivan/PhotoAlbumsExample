//
//  UserDetailsHeaderView.swift
//  photoalbumsexample
//
//  Created by Alejandro Melo Domínguez on 19-02-20.
//  Copyright © 2020 Alejandro Melo Domínguez. All rights reserved.
//

import UIKit

class UserDetailsHeaderView: UIView {
    private var containerView = UIView()
    weak var viewController: UserDetailsSceneDisplayLogic?

    // weak since strong references are created by addSubview()
    private weak var nameLabel: UILabel!
    private weak var phoneButton: UIButton!
    private weak var separatorView: UIView!

    // MARK: - Public variables
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }

    var phone: String? {
        didSet {
            phoneButton.setTitle(phone, for: .normal)
        }
    }

    // MARK: - Initializers

    convenience init(viewController: UserDetailsSceneDisplayLogic?) {
        self.init(frame: .zero)
        self.viewController = viewController
        setup()
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        setupNameLabel()
        setupPhoneButton()
        setupSeparator(lastView: phoneButton)
        layoutIfNeeded()
    }

    func setupNameLabel() {
        let label = UILabel()
        containerView.addSubview(label)
        nameLabel = label

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Colors.Labels.Title.font
        nameLabel.textColor = Colors.Labels.Title.color
        nameLabel.numberOfLines = 0

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            nameLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50)
        ])
    }

    func setupPhoneButton() {
        let button = UIButton()
        containerView.addSubview(button)
        phoneButton = button

        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        phoneButton.setTitleColor(Colors.Labels.Title.color, for: .normal)
        phoneButton.contentHorizontalAlignment = .left

        NSLayoutConstraint.activate([
            phoneButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            phoneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            phoneButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            phoneButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        phoneButton.addTarget(self, action: #selector(callUser), for: .touchUpInside)
    }

    func setupSeparator(lastView: UIView) {
        let separator = UIView()
        containerView.addSubview(separator)
        separatorView = separator

        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = Colors.Separators.background

        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 0),
            separatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension UserDetailsHeaderView {
    @objc
    func callUser() {
        guard let phoneString = phone, let url = URL(string: "tel://\(phoneString)") else { return }

        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 11.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(url)
            }
        }
    }
}
