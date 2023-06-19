import UIKit
import SnapKit
import Kingfisher
import SkeletonView

class SpotLightItemViewCell: UICollectionViewCell {
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        applyRoundedCorners()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupConstraints()
        applyRoundedCorners()
        showGradientSkeleton()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        isSkeletonable = true
        showAnimatedGradientSkeleton()
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func applyRoundedCorners() {
       layer.cornerRadius = 15
       layer.masksToBounds = false
       layer.shadowColor = UIColor.gray.cgColor
       layer.shadowOpacity = 0.5
       layer.shadowOffset = CGSize(width: 0, height: 2)
       layer.shadowRadius = 4
       layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
   }
    
    func configure(with imageURL: String) {
        if let url = URL(string: imageURL) {
            imageView.kf.setImage(with: url) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.hideSkeleton()
                    self?.imageView.image = value.image
                case .failure(let error):
                    self?.hideSkeleton()
                    print("Erro ao baixar a imagem: \(error)")
                }
            }
             
        }
    }
}
