import XCTest
@testable import desafioDigio

class HomeAdapterTests: XCTestCase {
    
    var adapter: HomeAdapter!
    
    override func setUp() {
        super.setUp()
        adapter = HomeAdapter()
    }
    
    override func tearDown() {
        adapter = nil
        super.tearDown()
    }
    
    func testPrepareHomeViewModel_WithEmptyHomeModel_ReturnsEmptyViewModel() {
        let homeModel = HomeModel(spotlight: [],
                                  products: [],
                                  cash: Cash(title: "", bannerURL: "", description: ""))
        
        let viewModel = adapter.prepareHomeViewModel(with: homeModel)
        
        XCTAssertTrue(viewModel.spotlight.isEmpty)
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertEqual(viewModel.cash.name, "")
        XCTAssertEqual(viewModel.cash.description, "")
        XCTAssertEqual(viewModel.cash.imageUrl, "")
    }
    
    func testPrepareHomeViewModel_WithNonEmptyHomeModel_ReturnsValidViewModel() {

        let spotlight1 = Spotlight(name: "Spotlight 1", bannerURL: "image1.png", description: "Description 1")
        let spotlight2 = Spotlight(name: "Spotlight 2", bannerURL: "image2.png", description: "Description 2")
        let product1 = Product(name: "Product 1", imageURL: "product1.png", description: "Description 1")
        let product2 = Product(name: "Product 2", imageURL: "product2.png", description: "Description 2")
        let cash = Cash(title: "Cash", bannerURL: "cash.png", description: "Cash Description")
        
        let homeModel = HomeModel(spotlight: [spotlight1, spotlight2],
                                  products: [product1, product2],
                                  cash: cash)
        
        let viewModel = adapter.prepareHomeViewModel(with: homeModel)
        
        XCTAssertEqual(viewModel.spotlight.count, 2)
        XCTAssertEqual(viewModel.products.count, 2)
        
        XCTAssertEqual(viewModel.spotlight[0].name, "Spotlight 1")
        XCTAssertEqual(viewModel.spotlight[0].description, "Description 1")
        XCTAssertEqual(viewModel.spotlight[0].imageUrl, "image1.png")
        
        XCTAssertEqual(viewModel.spotlight[1].name, "Spotlight 2")
        XCTAssertEqual(viewModel.spotlight[1].description, "Description 2")
        XCTAssertEqual(viewModel.spotlight[1].imageUrl, "image2.png")
        
        XCTAssertEqual(viewModel.products[0].name, "Product 1")
        XCTAssertEqual(viewModel.products[0].description, "Description 1")
        XCTAssertEqual(viewModel.products[0].imageUrl, "product1.png")
        
        XCTAssertEqual(viewModel.products[1].name, "Product 2")
        XCTAssertEqual(viewModel.products[1].description, "Description 2")
        XCTAssertEqual(viewModel.products[1].imageUrl, "product2.png")
        
        XCTAssertEqual(viewModel.cash.name, "Cash")
        XCTAssertEqual(viewModel.cash.description, "Cash Description")
        XCTAssertEqual(viewModel.cash.imageUrl, "cash.png")
    }
    
    func testPrepareHomeViewModel_WithSpotlightsOnly_ReturnsViewModelWithSpotlights() {
        
        let spotlight1 = Spotlight(name: "Spotlight 1", bannerURL: "image1.png", description: "Description 1")
        let spotlight2 = Spotlight(name: "Spotlight 2", bannerURL: "image2.png", description: "Description 2")
        
        let homeModel = HomeModel(spotlight: [spotlight1, spotlight2],
                                  products: [],
                                  cash: Cash(title: "", bannerURL: "", description: ""))
        
        let viewModel = adapter.prepareHomeViewModel(with: homeModel)
        
        XCTAssertEqual(viewModel.spotlight.count, 2)
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertTrue(viewModel.cash.name.isEmpty)
        XCTAssertTrue(viewModel.cash.description.isEmpty)
        XCTAssertTrue(viewModel.cash.imageUrl.isEmpty)
    }
    
    func testPrepareHomeViewModel_WithProductsOnly_ReturnsViewModelWithProducts() {
        
        let product1 = Product(name: "Product 1", imageURL: "product1.png", description: "Description 1")
        let product2 = Product(name: "Product 2", imageURL: "product2.png", description: "Description 2")
        
        let homeModel = HomeModel(spotlight: [],
                                  products: [product1, product2],
                                  cash: Cash(title: "", bannerURL: "", description: ""))
        
        let viewModel = adapter.prepareHomeViewModel(with: homeModel)
        
        XCTAssertTrue(viewModel.spotlight.isEmpty)
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertTrue(viewModel.cash.name.isEmpty)
        XCTAssertTrue(viewModel.cash.description.isEmpty)
        XCTAssertTrue(viewModel.cash.imageUrl.isEmpty)
    }
}
