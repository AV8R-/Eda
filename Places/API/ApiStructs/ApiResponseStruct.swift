import Foundation

struct ApiResponseStruct<Payload: Decodable>: Decodable {
    var payload: Payload
}
