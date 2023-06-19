import Foundation

@testable import desafioDigio

class HomePresenterStub: HomePresenterProtocol {

    var view: HomeViewDelegateProtocol?

    var fetchDigioHomeProductsCalled = false

    func fetchDigioHomeProducts() {
        fetchDigioHomeProductsCalled = true
    }
}
