import UIKit

struct HomeViewModel: Equatable {
    let spotlight: [ItemHomeViewModel]
    let products: [ItemHomeViewModel]
    let cash: ItemHomeViewModel
}

struct ItemHomeViewModel: Equatable {
    let name: String
    let description: String
    let imageUrl: String
}
