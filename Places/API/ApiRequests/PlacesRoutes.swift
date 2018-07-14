import Foundation

enum PlacesRoutes {
    static let places = ResourceRequest<PlacesPayload, [Place]>(
        method: .get,
        path: "/catalog",
        parameters: ["latitude": 55.762885, "longitude": 37.597360],
        map: { $0.foundPlaces.map { $0.place } }
    )
}
