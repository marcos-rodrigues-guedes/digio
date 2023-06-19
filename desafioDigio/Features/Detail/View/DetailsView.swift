import UIKit
import SnapKit
import Kingfisher

class DetailsView: UIView {
    
    private var scrollView: UIScrollView?
    private var contentView: UIView?
    private var imageView: UIImageView?
    private var textLabel: UILabel?
    private var descriptionLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        backgroundColor = .white
        
        scrollView = UIScrollView()
        addSubview(scrollView!)
        
        contentView = UIView()
        scrollView?.addSubview(contentView!)
        
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFit
        contentView?.addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel?.textAlignment = .left
        textLabel?.numberOfLines = 0
        contentView?.addSubview(textLabel!)
        
        descriptionLabel = UILabel()
        descriptionLabel?.textAlignment = .left
        descriptionLabel?.numberOfLines = 0
        contentView?.addSubview(descriptionLabel!)
        
    }
    
    private func setupConstraints() {
        
        scrollView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        imageView?.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.right.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        textLabel?.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(imageView!.snp.bottom).offset(20)
        }
        
        descriptionLabel?.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(textLabel!.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    public func configure(imageUrl: String, description: String, text: String) {
        imageView?.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "placeholder"))
        descriptionLabel?.text = description
        textLabel?.text = text
    }
}
