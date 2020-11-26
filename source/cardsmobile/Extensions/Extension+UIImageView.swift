
import UIKit

extension UIImageView {
    
    func load(url: URL) {
        
        if let image = ImageCacheService.getImage(key: url.absoluteString) {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        } else {
            DispatchQueue.global().async { [weak self] in
                guard let data = try? Data(contentsOf: url) else {return}
                guard let image = UIImage(data: data) else {return}
                ImageCacheService.setImage(image, key: url.absoluteString)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            }
            
        }
                
    }
    
}
