import UIKit
import SnapKit

final class PlaceTableViewCell: UITableViewCell {
    
    enum Constants {
        static let pictureSize = CGSize(width: 100, height: 75)
        static let offset: CGFloat = 16
    }
    
    let picture =           UIImageView(frame: .zero)
    let name =              UILabel()
    let placeDescription =  UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        name.font = UIFontMetrics(forTextStyle: .title1)
            .scaledFont(for: UIFont.systemFont(ofSize: 17))
        
        placeDescription.font = UIFontMetrics(forTextStyle: .body)
            .scaledFont(for: UIFont.systemFont(ofSize: 14))
        
        name.numberOfLines = 0
        placeDescription.numberOfLines = 0
        
        contentView.addSubview(picture)
        contentView.addSubview(name)
        contentView.addSubview(placeDescription)
        
        picture.snp.makeConstraints { make in
            make.left.top.equalTo(Constants.offset)
            make.size.equalTo(Constants.pictureSize)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(picture)
            make.left.equalTo(picture.snp.right).offset(Constants.offset)
            make.right.equalTo(-Constants.offset)
        }
        
        placeDescription.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(Constants.offset)
            make.left.right.equalTo(name)
            make.bottom.equalTo(-Constants.offset)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
    
}
