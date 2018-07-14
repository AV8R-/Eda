import Foundation
import class UIKit.UIImageView

protocol PicturesServiceProtocol {
    func setImage(from url: URL, to imageView: UIImageView)
    func dropCache()
}
