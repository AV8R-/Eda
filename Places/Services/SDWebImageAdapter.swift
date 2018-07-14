import Foundation
import SDWebImage
import class UIKit.UIImageView

final class SDWebImageAdapter: PicturesServiceProtocol {
    func setImage(from url: URL, to imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
        imageView.sd_setImage(with: url, completed: nil)
    }
    
    func dropCache() {
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
    
}
