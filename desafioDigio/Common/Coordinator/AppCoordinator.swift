import UIKit

class AppCoordinator: CoordinatorBase {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: UINavigationController())
    }
    
    func start() {
        let service = HomeService(networkManager: NetworkManager())
        let adapter = HomeAdapter()
        let coordinator = HomeCoordinator(navigationController: navigationController,
                                          presenter: HomePresenter(service: service, adapter: adapter))
        coordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
