import Foundation

@testable import desafioDigio

struct HomeRequestStub: RequestProtocol {
    var path: String = "/product"
    var method: RequestMethod = .get
}
