import Foundation
import struct CoreGraphics.CGSize
import class UIKit.UIImage

struct Picture: Decodable {
    private(set) var url: (CGSize) -> URL?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let urnFormat = try values.decode(String.self, forKey: .uri)
        url = {_ in nil}
        let uri = self.string(for: .uri)!
        
        url = { [uri = uri] size in
            URL(string: uri)?
                .appendingPathComponent(urnFormat
                    .replacingOccurrences(of: "{w}", with: "\(Int(size.width))")
                    .replacingOccurrences(of: "{h}", with: "\(Int(size.height))"))
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case uri
    }
}

extension Picture: ValueObtaining {}

struct Place: Decodable {
    let picture: Picture
    let name: String
    let description: String?
    
    
}
