import Foundation
import enum Alamofire.Result
import class Alamofire.SessionManager

final class PlacesService: PlacesServiceProtocol {
    let sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func places(_ completion: @escaping (Result<[Place]>) -> Void) {
        sessionManager.request(PlacesRoutes.places, completion: completion)
    }
}
