import Foundation

struct HomeRequest: RequestProtocol, Equatable {
    var path: String {
        return "/products"
    }
    var method: RequestMethod {
        return .get
    }
}
