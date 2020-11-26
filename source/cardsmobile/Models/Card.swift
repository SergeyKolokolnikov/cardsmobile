
import Foundation
import SQLite3

struct Card: Codable, Hashable, Equatable {
    let number: String
    let kind: String
    let barcode: Barcode
    let texture: Texture
    let loyaltyCard: LoyaltyCard?
    let certificate: Certificate?
    let issuer: Issuer

    private enum CodingKeys: String, CodingKey {
        case number
        case kind
        case barcode
        case texture
        case loyaltyCard
        case certificate
        case issuer
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Card.CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(kind, forKey: .kind)
        try container.encode(barcode, forKey: .barcode)
        try container.encode(texture, forKey: .texture)
        try container.encode(loyaltyCard, forKey: .loyaltyCard)
        try container.encode(certificate, forKey: .certificate)
        try container.encode(issuer, forKey: .issuer)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Card.CodingKeys.self)
        self.number = try container.decode(String.self, forKey: .number)
        self.kind = try container.decode(String.self, forKey: .kind)
        self.barcode = try container.decode(Barcode.self, forKey: .barcode)
        self.texture = try container.decode(Texture.self, forKey: .texture)
        self.loyaltyCard = try container.decodeIfPresent(LoyaltyCard.self, forKey: .loyaltyCard)
        self.certificate = try container.decodeIfPresent(Certificate.self, forKey: .certificate)
        self.issuer = try container.decode(Issuer.self, forKey: .issuer)
    }

}
