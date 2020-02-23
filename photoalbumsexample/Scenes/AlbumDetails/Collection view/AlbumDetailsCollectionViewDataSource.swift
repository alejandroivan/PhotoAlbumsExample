import UIKit

class AlbumDetailsCollectionViewDataSource: NSObject {
    weak var viewController: (AlbumDetailsCollectionViewLogic & AlbumDetailsDisplayLogic)?

    init(viewController: (AlbumDetailsCollectionViewLogic & AlbumDetailsDisplayLogic)?) {
        self.viewController = viewController
    }
}

extension AlbumDetailsCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController?.photos.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "AlbumDetailsCollectionViewCell",
            for: indexPath
        )
        cell.backgroundColor = .red
        return cell
    }
}
