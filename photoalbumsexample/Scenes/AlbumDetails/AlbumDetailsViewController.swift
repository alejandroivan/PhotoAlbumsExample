import Lightbox
import UIKit

protocol AlbumDetailsDisplayLogic: class {
    func displayPhotos(viewModel: AlbumDetails.FetchPhotos.ViewModel)
    func displayError()
}

protocol AlbumDetailsCollectionViewLogic: class {
    var photos: [PhotosViewModel] { get }
    func didSelectPhoto(at index: Int)
}

class AlbumDetailsViewController: UIViewController, AlbumDetailsDisplayLogic {
    var interactor: AlbumDetailsBusinessLogic?
    var router: (NSObjectProtocol & AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)?

    var photos: [PhotosViewModel] = []

    var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)
    weak var errorView: ErrorView?

    var collectionViewDataSource: AlbumDetailsCollectionViewDataSource? {
        didSet {
            collectionView.dataSource = collectionViewDataSource
        }
    }

    var collectionViewDelegate: AlbumDetailsCollectionViewDelegate? {
        didSet {
            collectionView.delegate = collectionViewDelegate
        }
    }

    var isLoading: Bool = false {
        didSet {
            if self.isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
//                self.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = AlbumDetailsInteractor()
        let presenter = AlbumDetailsPresenter()
        let router = AlbumDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = Constants.CollectionView.insets

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: getTopAnchor()),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        collectionViewDataSource = AlbumDetailsCollectionViewDataSource(viewController: self)
        collectionViewDelegate = AlbumDetailsCollectionViewDelegate(viewController: self)
        collectionView.register(
            AlbumDetailsCollectionViewCell.self,
            forCellWithReuseIdentifier: "AlbumDetailsCollectionViewCell"
        )
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.backgroundColor = Colors.ActivityIndicator.background
        activityIndicator.clipsToBounds = true
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.hidesWhenStopped = true

        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupActivityIndicator()
        title = router?.dataStore?.albumTitle ?? "Fotos del álbum"
        view.backgroundColor = Colors.ViewController.background

        fetchAlbumPhotos()
    }

    // MARK: Do something

    func fetchAlbumPhotos() {
        errorView?.removeFromSuperview()
        collectionView.topAnchor.constraint(equalTo: getTopAnchor())
        errorView = nil

        isLoading = true
        
        let request = AlbumDetails.FetchPhotos.Request()
        interactor?.loadPhotos(request: request)
    }

    func displayPhotos(viewModel: AlbumDetails.FetchPhotos.ViewModel) {
        isLoading = false
        photos = viewModel.photos
        collectionView.reloadData()
    }

    func displayError() {
        guard errorView == nil else { return }

        let errorView = ErrorView(delegate: self)
        self.errorView = errorView
        view.addSubview(errorView)
        view.bringSubviewToFront(errorView)

        let heightConstraint = NSLayoutConstraint(
            item: errorView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 0
        )

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: getTopAnchor()),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightConstraint
        ])

        isLoading = false

        UIView.animate(withDuration: 0.3, animations: {
            heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }) { _ in
            self.collectionView.topAnchor.constraint(equalTo: errorView.bottomAnchor)
        }
    }
}

extension AlbumDetailsViewController: AlbumDetailsCollectionViewLogic {
    func didSelectPhoto(at index: Int) {
        var images: [LightboxImage] = []
        for photo in photos {
            guard let url = photo.photoUrl else { continue }

            let image = LightboxImage(
                imageURL: url,
                text: photo.title ?? Constants.String.empty,
                videoURL: nil
            )

            images.append(image)
        }

        LightboxConfig.CloseButton.text = Constants.PhotoViewer.closeButton

        let controller = LightboxController(
            images: images,
            startIndex: index
        )
        controller.dynamicBackground = true

        navigationController?.present(controller, animated: true, completion: nil)
    }
}

extension AlbumDetailsViewController: ErrorViewDelegate {
    func didTouchErrorView() {
        collectionView.topAnchor.constraint(equalTo: getTopAnchor())
        fetchAlbumPhotos()
    }
}
