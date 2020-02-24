import UIKit

protocol AlbumDetailsPresentationLogic {
    func presentPhotos(response: AlbumDetails.FetchPhotos.Response)
}

class AlbumDetailsPresenter: AlbumDetailsPresentationLogic {
    weak var viewController: AlbumDetailsDisplayLogic?

    // MARK: Do something

    func presentPhotos(response: AlbumDetails.FetchPhotos.Response) {
        guard response.success else {
            viewController?.displayError()
            return
        }

        let viewModel = AlbumDetails.FetchPhotos.ViewModel(
            photos: response.photos.map {
                PhotosViewModel(
                    id: $0.id,
                    title: $0.title,
                    thumbnailUrl: $0.thumbnailUrl,
                    photoUrl: $0.url
                )
            }
        )

        viewController?.displayPhotos(viewModel: viewModel)
    }
}
