import XCTest
@testable import desafioDigio

class HomeServiceTests: XCTestCase {

    var service: HomeService!
    var networkManagerStub: NetworkManagerStub!
    
    override func setUp() {
        super.setUp()
        
        networkManagerStub = NetworkManagerStub()
        service = HomeService(networkManager: networkManagerStub)
    }
    
    override func tearDown() {
        service = nil
        networkManagerStub = nil
        
        super.tearDown()
    }
    
    func testGetDigioHomeProducts_Success() {
        
        let homeModel = HomeModel(spotlight: [], products: [], cash: Cash(title: "", bannerURL: "", description: ""))
        networkManagerStub.result = .success(homeModel)
        
        var result: Result<HomeModel, AppError>?
        service.getDigioHomeProducts { response in
            result = response
        }
        
        XCTAssertEqual(result, .success(homeModel))
        XCTAssertTrue(networkManagerStub.requestCalled)
        XCTAssertEqual(networkManagerStub.request as? HomeRequest, HomeRequest())
    }
    
    func testGetDigioHomeProducts_NetworkError() {
     
        let error = NetworkError.connectionError
        networkManagerStub.result = .failure(error)
        
        var result: Result<HomeModel, AppError>?
        service.getDigioHomeProducts { response in
            result = response
        }
        
        XCTAssertEqual(result, .failure(.connection))
        XCTAssertTrue(networkManagerStub.requestCalled)
        XCTAssertEqual(networkManagerStub.request as? HomeRequest, HomeRequest())
    }
    
    func testGetDigioHomeProducts_ServerError() {
       
        let error = NetworkError.serverError("Server error")
        networkManagerStub.result = .failure(error)
        
        var result: Result<HomeModel, AppError>?
        service.getDigioHomeProducts { response in
            result = response
        }
        
        XCTAssertEqual(result, .failure(.server))
        XCTAssertTrue(networkManagerStub.requestCalled)
        XCTAssertEqual(networkManagerStub.request as? HomeRequest, HomeRequest())
    }
}
