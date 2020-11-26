
import Foundation

struct Certificate: Codable, Hashable {
    let value: Double
    let expireDate: String
    
    private enum CodingKeys: String, CodingKey {
        case value
        case expireDate
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Certificate.CodingKeys.self)
        try container.encode(expireDate, forKey: .expireDate)
        try container.encode(value, forKey: .value)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Certificate.CodingKeys.self)
        self.expireDate = try container.decode(String.self, forKey: .expireDate)
        self.value = try container.decode(Double.self, forKey: .value)
    }

}
