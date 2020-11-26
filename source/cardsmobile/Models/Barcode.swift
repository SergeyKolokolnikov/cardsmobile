
import Foundation

struct Barcode: Codable, Hashable {
    let number: String
    let kind: String

    private enum CodingKeys: String, CodingKey {
        case number
        case kind
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Barcode.CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(kind, forKey: .kind)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Barcode.CodingKeys.self)
        self.number = try container.decode(String.self, forKey: .number)
        self.kind = try container.decode(String.self, forKey: .kind)
    }


}
