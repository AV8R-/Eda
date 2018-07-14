import Foundation

enum ValueKey: Hashable {
    case uri
    case api
}

protocol PlacesValuesProtocol {
    func string(for key: ValueKey) -> String?
}

final class ApplicationValues: PlacesValuesProtocol {
    private var values: [ValueKey: Any] = [:]
    
    init() {
        fillWithDefaults()
    }
    
    private func fillWithDefaults() {
        values[.uri] = "https://eda.yandex"
        values[.api] = "/api/v2"
    }
    
    func string(for key: ValueKey) -> String? {
        return values[key] as? String
    }
}

final class PlacesValues {
    internal var activeValues: PlacesValuesProtocol?

    private(set) static var shared = PlacesValues()
    private init() {}
    
    static func setShared(_ instance: PlacesValues) {
        shared = instance
    }
    
    func setupValues(_ values: PlacesValuesProtocol) {
        activeValues = values
    }
    
    func string(for key: ValueKey) -> String? {
        return activeValues?.string(for: key)
    }

}

protocol ValueObtaining {}

extension ValueObtaining {
    func string(for key: ValueKey) -> String? {
        return PlacesValues.shared.string(for: key)
    }
}
