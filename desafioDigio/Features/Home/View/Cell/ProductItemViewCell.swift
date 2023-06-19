import UIKit
import SnapKit
import Kingfisher

class ProductItemViewCell: UICollectionViewCell {
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        clipsToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.cornerRadius = 20.0
        layer.masksToBounds = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
        clipsToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.cornerRadius = 20.0
        layer.masksToBounds = false
        
    }
    
    private func setupViews() {
        isSkeletonable = true
        backgroundColor = .white
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(with imageURL: String) {
        if let url = URL(string: imageURL) {
            imageView.kf.setImage(with: url) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.hideSkeleton()
                    let resizedImage = value.image.resize(toWidth: CGFloat(50))
                    self?.imageView.image = resizedImage
                case .failure(let error):
                    print(error)
                    self?.hideSkeleton()
                    self?.imageView.image = UIImage(named: "placeholder")?.resize(toWidth: 50)
                }
            }
        }
    }
}
