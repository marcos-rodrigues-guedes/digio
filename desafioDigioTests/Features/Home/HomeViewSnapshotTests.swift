import XCTest
import SnapshotTesting
@testable import desafioDigio

class HomeViewSnapshotTests: XCTestCase {

    func testLoadingState() {
        let homeView = HomeView(frame: CGRect(x: 0, y: 0, width: 375, height: 812))
        homeView.show(homeViewModel: HomeViewLoading())

        assertSnapshot(matching: homeView, as: .image)
    }

    func testSuccessState() {
        let homeView = HomeView(frame: CGRect(x: 0, y: 0, width: 375, height: 812))
        
        let model = HomeFactory.createHomeViewModel()
        let viewModel = HomeViewSuccess(homeModel: model)
        homeView.show(homeViewModel: viewModel)

        assertSnapshot(matching: homeView, as: .image)
    }

    func testErrorState() {
        let homeView = HomeView(frame: CGRect(x: 0, y: 0, width: 375, height: 812))
        homeView.show(homeViewModel: HomeViewError(errorDescription: "Test Error"))

        assertSnapshot(matching: homeView, as: .image)
    }
}
