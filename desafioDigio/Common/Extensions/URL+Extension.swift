import UIKit

extension URL {
    func downloadImage(completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: self) { data, _, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
}
