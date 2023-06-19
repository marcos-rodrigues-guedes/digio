import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var detailView: DetailsView?
    let detail: ItemHomeViewModel
    
    init(detailView: DetailsView, detail: ItemHomeViewModel) {
        self.detailView = detailView
        self.detail = detail
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        detailView?.configure(imageUrl: detail.imageUrl,
                              description: detail.description,
                              text: detail.name)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailViewController {
    func setupUI() {
        guard let detailView = detailView else { return }
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
