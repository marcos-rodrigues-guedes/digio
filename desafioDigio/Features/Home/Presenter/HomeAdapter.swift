import Foundation
import UIKit

struct HomeAdapter: HomeAdapterProtocol {
    func prepareHomeViewModel(with homeModel: HomeModel) -> HomeViewModel {
        
        let spotlightsViewModel = homeModel.spotlight.map {
            return ItemHomeViewModel(name: $0.name,
                                     description: $0.description,
                                     imageUrl: $0.bannerURL)
        }
        
        let productsViewModel = homeModel.products.map {
            return ItemHomeViewModel(name: $0.name,
                                     description: $0.description,
                                     imageUrl: $0.imageURL)
        }
        
        let cashViewModel = ItemHomeViewModel(name: homeModel.cash.title,
                                              description: homeModel.cash.description,
                                              imageUrl: homeModel.cash.bannerURL)
        
        return HomeViewModel(spotlight: spotlightsViewModel, products: productsViewModel, cash: cashViewModel)
    }
}
