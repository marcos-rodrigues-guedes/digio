import Foundation
import UIKit

protocol HomeViewProtocol: class where Self: UIView {
    var onItemTapped: ((ItemHomeViewModel) -> Void)? {get set}
    func show(homeViewModel: HomeViewModelProtocol)
    
}

protocol HomeViewModelProtocol {
    var isLoading: Bool {get}
    var isError: Bool {get}
    var errorDescription: String {get}
    var homeModel: HomeViewModel? {get}
}

extension HomeViewModelProtocol {
    var isLoading: Bool {
        return false
    }
    
    var isError: Bool {
        return false
    }
    
    var errorDescription: String {
        return "generic error received"
    }
    
    var homeModel: HomeViewModel? {
        return nil
    }
}

struct HomeViewLoading: HomeViewModelProtocol {
    var isLoading: Bool = true
}

struct HomeViewSuccess: HomeViewModelProtocol {
    var homeModel: HomeViewModel?
}

struct HomeViewError: HomeViewModelProtocol {
    var errorDescription: String
    var isError: Bool = true
}
