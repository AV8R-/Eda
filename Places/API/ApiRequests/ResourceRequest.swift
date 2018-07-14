import Foundation
import Alamofire

final class ResourceRequest<ApiResponse, TargetResponse>: ApiRequest
where ApiResponse: Decodable, TargetResponse: Decodable {
    var method: HTTPMethod
    var path: String
    var parameters: [String: Any]?
    var map: (ApiResponse) -> TargetResponse
    
    init(
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]? = nil,
        map: @escaping (ApiResponse) -> TargetResponse
        )
    {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.map = map
    }
}

extension ResourceRequest where ApiResponse == TargetResponse {
    var map: (ApiResponse) -> TargetResponse {
        return { $0 }
    }
}
