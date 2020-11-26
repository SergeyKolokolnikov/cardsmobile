
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
      didSet {
        shrink(down: isHighlighted)
      }
    }
    
    private func shrink(down: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: {
            if down {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } else {
                self.transform = .identity
            }
        }) { (success) in
            self.transform = .identity
        }

    }
}

