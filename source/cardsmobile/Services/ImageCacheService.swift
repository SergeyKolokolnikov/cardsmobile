
import UIKit

class ImageCacheService {
    
    private static var cache = NSCache<NSString, UIImage>()
    
    static func setImage(_ image: UIImage, key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    static func getImage(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
}

