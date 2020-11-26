
import Foundation

class NetworkService: NSObject {
    
    static let shared = NetworkService()
        
    private var cardsPath = "https://textures.cardsmobile.ru/public/kmc.json"

    func fetchCards() -> [Card]? {
        
        guard let data = self.getJSON(urlToRequest: cardsPath) else {
            return nil
        }
        
        self.save(data)
        
        do {
            let result: [Card] = try JSONDecoder().decode([Card].self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func fetchLocalCards() -> [Card]? {
        
        guard let data = self.read() else {
            return nil
        }
        
        do {
            let result: [Card] = try JSONDecoder().decode([Card].self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    
    private func getJSON(urlToRequest: String) -> Data? {
        if let url = URL(string: urlToRequest) {
            do {
                return try Data(contentsOf: url)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    //MARK: - Local
    private func save(_ data: Data) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("kmc")
            do {
                try data.write(to: pathWithFilename)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func read() -> Data? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("kmc")
            do {
                return try Data(contentsOf: pathWithFilename)
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
