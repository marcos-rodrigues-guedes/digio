import Foundation

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewDelegateProtocol? {get set}
    func fetchDigioHomeProducts()
}
