
import Foundation

struct RecognizeText: Codable, Hashable {
    let image_url: String
    let text: String

    init(image_url: String, text: String) {
        self.image_url = image_url
        self.text = text
    }
    
    private enum CodingKeys: String, CodingKey {
        case image_url
        case text
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: RecognizeText.CodingKeys.self)
        try container.encode(image_url, forKey: .image_url)
        try container.encode(text, forKey: .text)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RecognizeText.CodingKeys.self)
        self.image_url = try container.decode(String.self, forKey: .image_url)
        self.text = try container.decode(String.self, forKey: .text)
    }


}
