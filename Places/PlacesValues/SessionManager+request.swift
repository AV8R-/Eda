import Alamofire

extension SessionManager {
    func request<R: ApiRequest>(_ apiRequest: R, completion: @escaping (Result<R.TargetResponse>) -> Void) {
        request(apiRequest)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                guard let data = response.data else {
                    completion(.failure(ApiError.nested(response.error)))
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let responseStruct = try decoder.decode(ApiResponseStruct<R.ApiResponse>.self, from: data)
                    completion(.success(apiRequest.map(responseStruct.payload)))
                } catch {
                    completion(.failure(error))
                }
                
            }
    }
}
