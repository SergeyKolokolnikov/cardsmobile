
import Foundation

extension String {
    
    var date: String {
        
        guard let timeStampDouble = self.doubleValueOptional  else {
            return self
        }

        let date = Date(timeIntervalSince1970: timeStampDouble)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd.MM.YYYY"
        
        let dateString = dayTimePeriodFormatter.string(from: date)
        return dateString
    }
    
    var doubleValue: Double {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = "."
        if let value = numberFormatter.number(from: self)?.doubleValue {
            return value
        } else {
            numberFormatter.decimalSeparator = ","
            return numberFormatter.number(from: self)?.doubleValue ?? 0
        }
    }
    
    var doubleValueOptional: Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = "."
        if let value = numberFormatter.number(from: self)?.doubleValue {
            return value
        } else {
            numberFormatter.decimalSeparator = ","
            return numberFormatter.number(from: self)?.doubleValue
        }
    }
}
