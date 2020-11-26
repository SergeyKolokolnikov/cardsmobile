
import Foundation
import SQLite3

class CardsVM: NSObject {

    private var allObjects: [Card]
    var completionHandler: (() -> Void) = {() -> Void in}

    // MARK: - Lifecycle
    override init() {
        self.allObjects = [Card]()
    }
    
    // MARK: - Public
    func getObjects() {

        if let result = NetworkService.shared.fetchLocalCards() {
            self.allObjects.removeAll()
            for item in result {
                self.allObjects.append(item)
            }
            self.completionHandler()
        }

        if let result = NetworkService.shared.fetchCards() {
            self.allObjects.removeAll()
            for item in result {
                self.allObjects.append(item)
            }
            self.completionHandler()
        }

    }

    func favorites() -> [Card] {
        return Array(allObjects.prefix(9))
    }

    func objects() -> [Card] {
        let count = allObjects.count - 10
        return Array(allObjects[10...count])
    }

}
