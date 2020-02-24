import AlamofireImage
import UIKit

class AlbumDetailsCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.af.cancelImageRequest()
        imageView.image = nil
    }

    func setup(imageUrl: URL?) {
        if imageView.superview == nil {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = Colors.ImageView.background
            addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        }

        if let url = imageUrl {
            imageView.af.setImage(withURL: url)
        }
    }
}
