@testable import desafioDigio

class HomeAdapterStub: HomeAdapterProtocol {
    var result: HomeViewModel?
    var prepareHomeViewModelCalled = false
    
    func prepareHomeViewModel(with homeModel: HomeModel) -> HomeViewModel {
        prepareHomeViewModelCalled = true
        return result ?? HomeViewModel(spotlight: [],
                                       products: [],
                                       cash: ItemHomeViewModel(name: "", description: "", imageUrl: ""))
    }
}
