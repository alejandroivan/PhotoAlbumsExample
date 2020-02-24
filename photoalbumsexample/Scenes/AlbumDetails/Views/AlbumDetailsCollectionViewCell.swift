//
//  AlbumDetailsCollectionViewCell.swift
//  photoalbumsexample
//
//  Created by Alejandro Melo Domínguez on 23-02-20.
//  Copyright © 2020 Alejandro Melo Domínguez. All rights reserved.
//

import UIKit

class AlbumDetailsCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func prepare(imageUrl: URL?) {
        guard let url = imageUrl else {
            return
        }
    }
}
