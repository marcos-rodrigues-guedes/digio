@testable import desafioDigio

class HomeViewDelegateStub: HomeViewDelegateProtocol {
    var didReceiveHomeProductsCalled = false
    var didReceiveHomeProductsViewModel: HomeViewModel?
    var didReceiveErrorCalled = false
    var didReceiveErrorDescription: String?
    
    func didReceiveHomeProducts(homeViewModel: HomeViewModel) {
        didReceiveHomeProductsCalled = true
        didReceiveHomeProductsViewModel = homeViewModel
    }
    
    func didReceiveError(description: String) {
        didReceiveErrorCalled = true
        didReceiveErrorDescription = description
    }
}
