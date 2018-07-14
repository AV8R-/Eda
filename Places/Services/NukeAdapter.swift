import Foundation
import Nuke

final class NukeAdapter: PicturesServiceProtocol {
    func setImage(from url: URL, to imageView: UIImageView) {
        Nuke.cancelRequest(for: imageView)
        Nuke.loadImage(with: url, into: imageView)
    }
    
    func dropCache() {
        Nuke.ImageCache.shared.removeAll()
    }
}
