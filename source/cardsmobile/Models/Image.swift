
// для хранения соотвествия url картинки и ее имени на диске
import Foundation

struct Image: Codable, Hashable {
    let image_url: String
    let uuid: String

    init(image_url: String, uuid: String) {
        self.image_url = image_url
        self.uuid = uuid
    }
    
    private enum CodingKeys: String, CodingKey {
        case image_url
        case uuid
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Image.CodingKeys.self)
        try container.encode(image_url, forKey: .image_url)
        try container.encode(uuid, forKey: .uuid)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Image.CodingKeys.self)
        self.image_url = try container.decode(String.self, forKey: .image_url)
        self.uuid = try container.decode(String.self, forKey: .uuid)
    }


}
