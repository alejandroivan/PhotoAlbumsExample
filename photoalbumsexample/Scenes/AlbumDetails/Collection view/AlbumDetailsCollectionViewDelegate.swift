import UIKit

class AlbumDetailsCollectionViewDelegate: NSObject {
    weak var viewController: (AlbumDetailsCollectionViewLogic & AlbumDetailsDisplayLogic)?

    init(viewController: (AlbumDetailsCollectionViewLogic & AlbumDetailsDisplayLogic)?) {
        self.viewController = viewController
    }
}

extension AlbumDetailsCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController?.didSelectPhoto(at: indexPath.row)
    }
}
