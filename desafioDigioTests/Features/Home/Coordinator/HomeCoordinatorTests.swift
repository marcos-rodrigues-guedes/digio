import XCTest
@testable import desafioDigio

class HomeCoordinatorTests: XCTestCase {
    
    var navigationController: UINavigationController!
    var presenter: HomePresenterStub!
    var coordinator: HomeCoordinator!
    
    override func setUp() {
        super.setUp()
        navigationController = UINavigationController()
        presenter = HomePresenterStub()
        coordinator = HomeCoordinator(navigationController: navigationController, presenter: presenter)
    }
    
    override func tearDown() {
        navigationController = nil
        presenter = nil
        coordinator = nil
        super.tearDown()
    }
    
    func testStart() {
        coordinator.start(animated: false)
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.viewControllers.first is HomeViewController)
    }
}
