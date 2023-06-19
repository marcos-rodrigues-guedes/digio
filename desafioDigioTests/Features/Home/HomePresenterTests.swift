import XCTest
@testable import desafioDigio

class HomePresenterTests: XCTestCase {

    var presenter: HomePresenter!
    var homeServiceStub: HomeServiceStub!
    var homeAdapterStub: HomeAdapterStub!
    var homeViewDelegateStub: HomeViewDelegateStub!
    
    override func setUp() {
        super.setUp()
        
        homeServiceStub = HomeServiceStub()
        homeAdapterStub = HomeAdapterStub()
        homeViewDelegateStub = HomeViewDelegateStub()
        
        presenter = HomePresenter(service: homeServiceStub, adapter: homeAdapterStub)
        presenter.view = homeViewDelegateStub
    }
    
    override func tearDown() {
        presenter = nil
        homeServiceStub = nil
        homeAdapterStub = nil
        homeViewDelegateStub = nil
        
        super.tearDown()
    }
    
    func testFetchDigioHomeProducts_Success() {
        // Arrange
        let homeModel = HomeModel(spotlight: [], products: [], cash: Cash(title: "", bannerURL: "", description: ""))
        homeServiceStub.result = .success(homeModel)
        
        let homeViewModel = HomeViewModel(spotlight: [],
                                          products: [],
                                          cash: ItemHomeViewModel(name: "", description: "", imageUrl: ""))
        homeAdapterStub.result = homeViewModel
        
        // Act
        presenter.fetchDigioHomeProducts()
        
        // Assert
        XCTAssertTrue(homeServiceStub.getDigioHomeProductsCalled)
        XCTAssertTrue(homeAdapterStub.prepareHomeViewModelCalled)
        XCTAssertTrue(homeViewDelegateStub.didReceiveHomeProductsCalled)
        XCTAssertEqual(homeViewDelegateStub.didReceiveHomeProductsViewModel, homeViewModel)
        XCTAssertFalse(homeViewDelegateStub.didReceiveErrorCalled)
    }
    
    func testFetchDigioHomeProducts_Failure() {
        // Arrange
        let errorDescription = "Falha na comunicação com o servidor, tente novamente"
        homeServiceStub.result = .failure(.server)
        
        // Act
        presenter.fetchDigioHomeProducts()
        
        // Assert
        XCTAssertTrue(homeServiceStub.getDigioHomeProductsCalled)
        XCTAssertFalse(homeAdapterStub.prepareHomeViewModelCalled)
        XCTAssertFalse(homeViewDelegateStub.didReceiveHomeProductsCalled)
        XCTAssertTrue(homeViewDelegateStub.didReceiveErrorCalled)
        XCTAssertEqual(homeViewDelegateStub.didReceiveErrorDescription, errorDescription)
    }
    
    func testFetchDigioHomeProducts_WhenViewIsReleased_DoesNotCallView() {
        // Arrange
        let homeModel = HomeModel(spotlight: [], products: [], cash: Cash(title: "", bannerURL: "", description: ""))
        homeServiceStub.result = .success(homeModel)
        
        let homeViewModel = HomeViewModel(spotlight: [],
                                          products: [],
                                          cash: ItemHomeViewModel(name: "", description: "", imageUrl: ""))
        homeAdapterStub.result = homeViewModel
        
        // Act
        presenter.view = nil
        presenter.fetchDigioHomeProducts()
        
        // Assert
        XCTAssertTrue(homeServiceStub.getDigioHomeProductsCalled)
        XCTAssertTrue(homeAdapterStub.prepareHomeViewModelCalled)
        XCTAssertFalse(homeViewDelegateStub.didReceiveHomeProductsCalled)
        XCTAssertFalse(homeViewDelegateStub.didReceiveErrorCalled)
    }
}
