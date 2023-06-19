import XCTest

@testable import desafioDigio

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        sut = NetworkManager(session: urlSession)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSuccessfulRequest() {
        let expectation = XCTestExpectation(description: "Successful request")
        
        let request = HomeRequest()
        
        let testResponseSuccess = TestsUtils.getSuccessProductsResponse()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: request.url?.absoluteString ?? String())!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, testResponseSuccess)
        }
        
        sut.request(request) { (result: Result<HomeModel, NetworkError>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.products.count, 3)
                XCTAssertEqual(response.spotlight.count, 2)
                XCTAssertEqual(response.cash.title, "digio Cash")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Request failed with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFailedRequest() {
        let expectation = XCTestExpectation(description: "Bad Request")
        let request = HomeRequestStub()
        let testResponse =
             """
            {
              "message": "Bad Request"
            }
            """.data(using: .utf8)
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: request.url?.absoluteString ?? String())!,
                                           statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, testResponse)
        }
        
        sut.request(request) { (result: Result<HomeModel, NetworkError>) in
            switch result {
            case .success:
                XCTFail("Request should have failed")
            case .failure(let error):
                XCTAssertEqual(error, .badRequest(code: 403, error: "Bad Request"))
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}
