import XCTest
@testable import desafioDigio

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController!
    var presenterStub: HomePresenterStub!
    var homeViewStub: HomeViewStub!
    
    override func setUp() {
        super.setUp()
        presenterStub = HomePresenterStub()
        homeViewStub = HomeViewStub()
        sut = HomeViewController(presenter: presenterStub, homeView: homeViewStub)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        presenterStub = nil
        homeViewStub = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(presenterStub.fetchDigioHomeProductsCalled)
    }
    
    func testViewDidLoad_SetsViewDelegate() {
        sut.viewDidLoad()
        XCTAssertNotNil(presenterStub.view)
        XCTAssertTrue(presenterStub.view === sut)
    }
    
    func testViewDidLoad_ShowsLoadingView() {
        let mockView = HomeViewStub()
        sut.homeView = mockView
        sut.viewDidLoad()
        XCTAssertTrue(mockView.showCalled)
        XCTAssertTrue(mockView.homeViewModel.isLoading)
        XCTAssertTrue(mockView.homeViewModel is HomeViewLoading)
    }
    
    func testDidReceiveHomeProducts_ShowsHomeViewSuccess() {
        // Arrange
        let expectation = XCTestExpectation(description: "Método assíncrono deve ser chamado")
        let expectedViewModel = HomeViewModel(spotlight: [],
                                              products: [],
                                              cash: ItemHomeViewModel(name: "Cash",
                                                                      description: "Cash Description",
                                                                      imageUrl: ""))
        
        homeViewStub.showClosure = { viewModel in
            // Assert
            XCTAssertTrue(viewModel is HomeViewSuccess)
            XCTAssertEqual((viewModel as? HomeViewSuccess)?.homeModel, expectedViewModel)
            expectation.fulfill()
        }
        
        // Act
        sut.didReceiveHomeProducts(homeViewModel: expectedViewModel)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDidReceiveError() {
        // Verifica se o método didReceiveError atualiza corretamente a view
        let expectation = XCTestExpectation(description: "Método assíncrono deve ser chamado")
       
        let mockErrorDescription = "Error description"
        
        homeViewStub.showClosure = { viewModel in
            // Verifique se o método show de mockHomeView foi chamado com o HomeViewError correto
            XCTAssertTrue(viewModel is HomeViewError)
            XCTAssertEqual(viewModel.errorDescription, mockErrorDescription)
            expectation.fulfill()
        }
        
        sut.didReceiveError(description: mockErrorDescription)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
