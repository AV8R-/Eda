import Alamofire

enum ApiError: Error {
    case uriWasNotSet
    case nested(Error?)
    case deserializationError
}

protocol ApiRequest: URLRequestConvertible, ValueObtaining {
    associatedtype ApiResponse: Decodable
    associatedtype TargetResponse: Decodable
        
    var contentType: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var map: (ApiResponse) -> TargetResponse { get }
    
}

extension ApiRequest {

    var contentType: String {
        return "application/json"
    }
    
    public func asURLRequest() throws -> URLRequest {
        guard let uri = string(for: .uri), let api = string(for: .api) else {
            throw ApiError.uriWasNotSet
        }
        
        // Неправильный uri может быть установлен только по ошибке программиста
        // Поэтому следуем принципу Fail fast
        let url = URL(string: uri)!
            .appendingPathComponent(api)
            .appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = method.rawValue
        
        return method == .get
            ? try URLEncoding.default.encode(request, with: parameters)
            : try JSONEncoding.default.encode(request, with: parameters)
    }
}
