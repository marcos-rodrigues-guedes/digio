@testable import desafioDigio

enum HomeFactory {
    static func createHomeViewModel() -> HomeViewModel {
        let s1 = Spotlight(name: "Recarga",
                           bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/recharge_banner.png",
                           description: "Agora ficou mais fácil colocar créditos no seu celular.")
        let s2 = Spotlight(name: "Uber",
                           bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/uber_banner.png",
                           description: "Dê um vale presente Uber para amigos e familiares")
        
        let p1 = Product(name: "XBOX",
                         imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/xbox_icon.png",
                         description: "Com o e-Gift Card Xbox você adquire créditos para comprar games, música, filmes, programas de TV e muito mais!")
        
        let p2 = Product(name: "Google Play",
                         imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/google_play_icon.png",
                         description: "O e-gift Google Play dá acesso a um mundo de entretenimento")
        
        let cash = Cash(title: "digio Cash",
                        bannerURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png",
                        description: "Dinheiro na conta sem complicação. Transfira parte do limite do seu cartão para sua conta.")
        
        let homeModel = HomeModel(spotlight: [s1, s2], products: [p1, p2], cash: cash)
        
        return HomeAdapter().prepareHomeViewModel(with: homeModel)
        
    }
}
