
import Foundation

struct Issuer: Codable, Hashable {
    let name: String
    let categories: [String]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case categories
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Issuer.CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(categories, forKey: .categories)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Issuer.CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.categories = try container.decode([String].self, forKey: .categories)
    }

}

