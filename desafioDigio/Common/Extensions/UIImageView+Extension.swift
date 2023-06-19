import UIKit
extension UIImageView {
    func load(url: URL, targetSize: CGSize) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image.scalePreservingAspectRatio(targetSize: targetSize)
                    }
                }
            }
        }
    }
}
