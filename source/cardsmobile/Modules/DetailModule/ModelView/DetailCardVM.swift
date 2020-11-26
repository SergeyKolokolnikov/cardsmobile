
import UIKit
import SDWebImage

class DetailCardVM: DetailModuleDelegate {

    private var card: Card?

    // MARK: -
    convenience init(card: Card) {
        self.init()
        self.card = card
    }
        
    // MARK: -

    func generateBarcode(handler: @escaping ((UIImage?) -> Void)) {
        guard let card = card else {return}
        
        DispatchQueue.global().async {
            if let image = ImageCacheService.getImage(key: card.barcode.number) {
                handler(image)
            }
            
            let data = card.barcode.number.data(using: String.Encoding.ascii)
            
            if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 3, y: 3)
                
                if let output = filter.outputImage?.transformed(by: transform) {
                    let image = UIImage(ciImage: output)
                    handler(image)
                }
            }
        }
        
    }

    
    func getFrontPreviewImageUrl() -> URL? {
        guard let card = card else {return nil}
        return URL(string: card.texture.front)
    }

    func getBackPreviewImageUrl() -> URL? {
        guard let card = card else {return nil}
        return URL(string: card.texture.back)
    }

    func getAdditionalIbfoText() -> String {
        guard let card = card else {return ""}
        guard let certificate = card.certificate else {return ""}
        return "* Сертификат истекает \(certificate.expireDate.date)"
    }
    
    func getTextBack(handler: @escaping ((String?) -> Void)) {
        guard let card = card else {
            return
        }
        DispatchQueue.global().async {
            RecognizeTextService.shared.getTextFrom(card.texture.back, handler: handler)
        }

    }
    
    func getTextFront(handler: @escaping ((String?) -> Void)) {
        guard let card = card else {
            return
        }
        DispatchQueue.global().async {
            RecognizeTextService.shared.getTextFrom(card.texture.front, handler: handler)
        }
    }


}
