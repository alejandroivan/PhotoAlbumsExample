import Alamofire
import Foundation

class ApiClient {
    static func get(
        _ url: URL,
        success: @escaping (Data) -> Void,
        failure: @escaping (Error?) -> Void
    ) {
        URLCache.shared.removeAllCachedResponses() // Alamofire/URLSession must not save cache, we'll do it manually

        let request = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)

        request.responseJSON { response in
            guard let data = response.data else {
                failure(response.error)
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
        URLCache.shared.removeAllCachedResponses() // Alamofire/URLSession must not save cache, we'll do it manually

        let request = AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)

        request.responseJSON { response in
            guard let data = response.data else {
                failure(response.error)
                return
            }

            success(data)
        }
    }
}
