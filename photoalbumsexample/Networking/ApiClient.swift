import Alamofire
import Foundation
import SystemConfiguration

protocol ApiClientReachability {
    static var isNetworkReachable: Bool { get }
}

class ApiClient {
    static func get(
        _ url: URL,
        success: @escaping (Data) -> Void,
        failure: @escaping (Error?) -> Void
    ) {
        guard isNetworkReachable else {
            let error: ApiClientError = .networkNotReachable
            failure(error)
            return
        }

        // We'll let Alamofire handle the cache through URLCache, we just need to set the cachePolicy
        AF.sessionConfiguration.requestCachePolicy = .reloadRevalidatingCacheData

        let request = AF.request(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: nil
        )

        request.responseJSON { response in
            guard let data = response.data else {
                let error: ApiClientError = .noDataFromEndpoint(response.error)
                failure(error)
                return
            }

            success(data)
        }
    }

    static func post(
        _ url: URL,
        params: [String: Any],
        success: @escaping (Data) -> Void,
        failure: @escaping (Error?) -> Void
    ) {
        guard isNetworkReachable else {
            let error: ApiClientError = .networkNotReachable
            failure(error)
            return
        }

        // We'll let Alamofire handle the cache through URLCache, we just need to set the cachePolicy
        AF.sessionConfiguration.requestCachePolicy = .reloadRevalidatingCacheData

        let request = AF.request(
            url,
            method: .post,
            parameters: params,
            encoding: URLEncoding.default,
            headers: nil
        )
        
        request.responseJSON { response in
            guard let data = response.data else {
                let error: ApiClientError = .noDataFromEndpoint(response.error)
                failure(error)
                return
            }

            success(data)
        }
    }
}

extension ApiClient: ApiClientReachability {
    static var isNetworkReachable: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags = SCNetworkReachabilityFlags()

        guard SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) else {
            return false
        }

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
