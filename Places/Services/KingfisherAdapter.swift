import Foundation
import Kingfisher

final class KingfisherAdapter: PicturesServiceProtocol {
    func setImage(from url: URL, to imageView: UIImageView) {
        imageView.kf.cancelDownloadTask()
        imageView.kf.setImage(with: url)
    }
    
    func dropCache() {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache()
    }
}
