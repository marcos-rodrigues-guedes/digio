import Foundation
import UIKit
import SnapKit

class ErrorView: UIView {
    
    private var imageView: UIImageView?
    private var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        imageView = UIImageView(image: UIImage(named: "error"))
        guard let imageView = imageView else { return }
        addSubview(imageView)
        
        titleLabel = UILabel()
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = .black
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        guard let titleLabel = titleLabel else { return }
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func showErrorInView(_ view: UIView, title: String) {
        titleLabel?.text = title
        frame = view.bounds
        view.addSubview(self)
    }
    
    func hide() {
        removeFromSuperview()
    }
}
