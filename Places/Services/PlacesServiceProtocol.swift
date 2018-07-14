import Foundation
import enum Alamofire.Result

protocol PlacesServiceProtocol {
    func places(_ completion: @escaping (Result<[Place]>) -> Void)
}
