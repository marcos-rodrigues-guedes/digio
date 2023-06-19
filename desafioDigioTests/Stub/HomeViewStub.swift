import UIKit

@testable import desafioDigio

class HomeViewStub: UIView, HomeViewProtocol {
    
    var onItemTapped: ((ItemHomeViewModel) -> Void)?
    var showClosure: ((HomeViewModelProtocol) -> Void)?
    
    var setupUICalled = false
    var setupViewClosuresCalled = false
    var showCalled = false
    var homeViewModel: HomeViewModelProtocol!

    func setupUI() {
        setupUICalled = true
    }

    func setupViewClosures() {
        setupViewClosuresCalled = true
    }
    
    func show(homeViewModel: HomeViewModelProtocol) {
        showCalled = true
        self.homeViewModel = homeViewModel
        showClosure?(self.homeViewModel)
    }
}
