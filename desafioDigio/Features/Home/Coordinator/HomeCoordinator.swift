import Foundation
import UIKit

class HomeCoordinator: CoordinatorBase {
    
    private let presenter: HomePresenterProtocol
    
    init(navigationController: UINavigationController, presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(navigationController: navigationController)
    }
    
    public override func start(animated: Bool = true) {
        let viewController = createHomeViewController()
        pushView(viewController: viewController, animated: animated)
    }
    
    private func createHomeViewController() -> HomeViewController {
        let homeView = HomeView()
        let viewController = HomeViewController(presenter: presenter, homeView: homeView)
        
        viewController.goToDetail = { item in
            self.goToDetail(itemHome: item)
        }
        
        return viewController
    }
    
    func goToDetail(itemHome: ItemHomeViewModel) {
        let detailView = DetailsView()
        let detailViewController = DetailViewController(detailView: detailView, detail: itemHome)
        presentView(viewController: detailViewController)
    }
}
