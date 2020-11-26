
import Foundation

struct LoyaltyCard: Codable, Hashable {
    let grade: String
    let balance: Double
    
    private enum CodingKeys: String, CodingKey {
        case grade
        case balance
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LoyaltyCard.CodingKeys.self)
        try container.encode(grade, forKey: .grade)
        try container.encode(balance, forKey: .balance)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LoyaltyCard.CodingKeys.self)
        self.grade = try container.decode(String.self, forKey: .grade)
        self.balance = try container.decode(Double.self, forKey: .balance)
    }

}
