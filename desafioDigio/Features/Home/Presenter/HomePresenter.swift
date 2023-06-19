import Foundation

final class HomePresenter: HomePresenterProtocol {
    
    var view: HomeViewDelegateProtocol?

    private let service: HomeServiceProtocol
    
    private let adapter: HomeAdapterProtocol
    
    public init(service: HomeServiceProtocol, adapter: HomeAdapterProtocol) {
        self.service = service
        self.adapter = adapter
    }
    
    func fetchDigioHomeProducts() {
        service.getDigioHomeProducts { [weak self] (result: Result<HomeModel, AppError>) in
            switch result {
            case .success(let data):
                let homeViewModel = self?.adapter.prepareHomeViewModel(with: data)
                guard let model = homeViewModel else { return }
                self?.view?.didReceiveHomeProducts(homeViewModel: model)
            case .failure(let failure):
                self?.view?.didReceiveError(description: failure.description)
            }
        }
    }
    
}
