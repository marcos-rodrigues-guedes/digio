import XCTest
import SnapshotTesting
@testable import desafioDigio

class DetailsViewSnapshotTests: XCTestCase {
    
    func testDetailsViewWithContent() {
        let view = DetailsView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        view.configure(imageUrl: "https://example.com/image.jpg",
                       description: "Product description",
                       text: "Some text content")
        
        assertSnapshot(matching: view, as: .image)
    }
    
    func testDetailsViewWithoutContent() {
        let view = DetailsView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        view.configure(imageUrl: "", description: "", text: "")
        
        assertSnapshot(matching: view, as: .image)
    }
}
