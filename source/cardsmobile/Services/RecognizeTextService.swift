import Foundation
import Vision

class RecognizeTextService: NSObject {
    
    static let shared = RecognizeTextService()

    func getTextFrom(_ url: String, handler: @escaping ((String?) -> Void)) {
        
        if let recognizeText = try? SQLService.sqliteDecoder?.decode(RecognizeText.self, using: RecognizeTextService.fetchByURL, arguments: ["image_url": .text(url)]) {
            handler(recognizeText.text)
        } else {
            self.addTextFrom(url: url, handler: handler)
        }

    }
    
    private func addTextFrom(url: String, handler: @escaping ((String?) -> Void)) {
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let requestHandler = VNImageRequestHandler(url: imageURL, options: [:])

        let request = VNRecognizeTextRequest { (request, error) in

            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                handler(nil)
                return
            }

            for observation in observations {

                let topCandidate: [VNRecognizedText] = observation.topCandidates(1)

                if let recognizedText: VNRecognizedText = topCandidate.first {
                    handler(recognizedText.string)
                    let rText = RecognizeText(image_url: url, text: recognizedText.string)
                    self.addText(rText)
                    return
                }
            }
            
            handler(nil)

        }
                
        request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
                
        do {
            try requestHandler.perform([request])
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    
    private func addText(_ recognizeText: RecognizeText) {
     
        do {
            try SQLService.sqliteEncoder?.encode(recognizeText, using: RecognizeTextService.upsert)
        } catch  {
            print(error.localizedDescription)
        }

    }

}

extension RecognizeTextService {
    
    static var createTable: SQL {
        return "CREATE TABLE IF NOT EXISTS recognizedText (image_url TEXT NOT NULL, text TEXT);"
    }

    static var upsert: SQL {
        return "INSERT OR REPLACE INTO recognizedText VALUES (:image_url, :text);"
    }

    static var fetchByURL: SQL {
        return "SELECT image_url, text FROM recognizedText WHERE image_url=:image_url;"
    }

}
