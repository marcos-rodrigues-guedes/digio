import Foundation

struct HomeModel: Codable, Equatable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}

struct Spotlight: Codable, Equatable {
    let name: String
    let bannerURL: String
    let description: String
}

struct Product: Codable, Equatable {
    let name: String
    let imageURL: String
    let description: String
}

struct Cash: Codable, Equatable {
    let title: String
    let bannerURL: String
    let description: String
}
