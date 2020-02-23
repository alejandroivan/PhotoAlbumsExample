import Alamofire

enum ApiClientError: Error {
    case networkNotReachable
    case noDataFromEndpoint(Error?)
}
