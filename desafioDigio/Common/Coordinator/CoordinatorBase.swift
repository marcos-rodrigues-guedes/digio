import UIKit

class CoordinatorBase: CoordinatorProtocol {
    
    public let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        fatalError("should implement `start`.")
    }
    
    public func pushView(viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func presentView(viewController: UIViewController, animated: Bool = true) {
        navigationController.present(viewController, animated: animated, completion: nil)
    }
    
    public func popView(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}
