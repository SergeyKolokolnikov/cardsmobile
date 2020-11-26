
import Foundation

struct Texture: Codable, Hashable {
    let front: String
    let back: String
    
    private enum CodingKeys: String, CodingKey {
        case front
        case back
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Texture.CodingKeys.self)
        try container.encode(front, forKey: .front)
        try container.encode(back, forKey: .back)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Texture.CodingKeys.self)
        self.front = try container.decode(String.self, forKey: .front)
        self.back = try container.decode(String.self, forKey: .back)
    }

}
