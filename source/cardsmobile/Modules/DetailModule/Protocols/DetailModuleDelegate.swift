
import UIKit

protocol DetailModuleDelegate {
    
    func getAdditionalIbfoText() -> String
    func getFrontPreviewImageUrl() -> URL?
    func getBackPreviewImageUrl() -> URL?
    
    func getTextBack(handler: @escaping ((String?) -> Void))
    func getTextFront(handler: @escaping ((String?) -> Void))
    func generateBarcode(handler: @escaping ((UIImage?) -> Void))
}
