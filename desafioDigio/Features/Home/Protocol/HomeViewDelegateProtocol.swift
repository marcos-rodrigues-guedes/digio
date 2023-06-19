import Foundation

protocol HomeViewDelegateProtocol: AnyObject {
    func didReceiveHomeProducts(homeViewModel: HomeViewModel)
    func didReceiveError(description: String)
}
