import UIKit

struct Colors {
    enum NavigationBar {
        static let text = UIColor.white
        static let background = UIColor.orange
    }

    enum ViewController {
        static let background = UIColor.white
    }

    enum ActivityIndicator {
        static let background = UIColor.black.withAlphaComponent(0.6)
    }

    enum ErrorView {
        static let background = UIColor.red
        static let message = UIColor.white
    }

    enum PullToRefresh {
        static let background = UIColor.white
        static let indicator = UIColor.darkGray
    }

    enum Labels {
        enum Title {
            static let font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
            static let color = UIColor.darkGray
        }
    }
}
