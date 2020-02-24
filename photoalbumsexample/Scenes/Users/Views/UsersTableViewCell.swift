//
//  UsersTableViewCell.swift
//  photoalbumsexample
//
//  Created by Alejandro Melo Domínguez on 19-02-20.
//  Copyright © 2020 Alejandro Melo Domínguez. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    private var user: User?

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }

    func setup(user: User) {
        selectionStyle = .gray
        accessoryType = .disclosureIndicator
        separatorInset = .zero

        textLabel?.text = user.name
    }
}
