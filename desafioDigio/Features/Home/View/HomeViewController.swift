import Foundation
import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let presenter: HomePresenterProtocol
    
    var homeView: HomeViewProtocol?
    
    public var goToDetail: ((ItemHomeViewModel) -> Void)?
    
    init(presenter: HomePresenterProtocol, homeView: HomeViewProtocol) {
        self.presenter = presenter
        self.homeView = homeView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewClosures()
        presenter.view = self
        homeView?.show(homeViewModel: HomeViewLoading())
        presenter.fetchDigioHomeProducts()
    }
}

private extension HomeViewController {
    func setupUI() {
        guard let carouselView = homeView else { return }
        view.addSubview(carouselView)
        carouselView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupViewClosures() {
        homeView?.onItemTapped = { [weak self] item in
            self?.goToDetail?(item)
        }
    }
}

extension HomeViewController: HomeViewDelegateProtocol {
    func didReceiveHomeProducts(homeViewModel: HomeViewModel) {
        DispatchQueue.main.async {
            self.homeView?.show(homeViewModel: HomeViewSuccess(homeModel: homeViewModel))
        }
        
    }
    
    func didReceiveError(description: String) {
        DispatchQueue.main.async {
            self.homeView?.show(homeViewModel: HomeViewError(errorDescription: description))
        }
    }
}
