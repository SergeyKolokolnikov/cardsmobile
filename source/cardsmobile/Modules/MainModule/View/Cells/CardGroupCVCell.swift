
import UIKit

class CardGroupCVCell: UICollectionViewCell {

    static let identifier = "CardGroupCVCell"
    
    private var cardsGroupCVC: CardsGroupCVC!
    
    // MARK: - Lyfecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width = UIScreen.main.bounds.width/3.18
        let height = width*0.7*3.9

        let cardsGroupCVC = CardsGroupCVC()

        self.contentView.addSubview(cardsGroupCVC.view)
        
        cardsGroupCVC.view.translatesAutoresizingMaskIntoConstraints = false
        cardsGroupCVC.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        cardsGroupCVC.view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        cardsGroupCVC.view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8).isActive = true
        cardsGroupCVC.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        cardsGroupCVC.view.heightAnchor.constraint(equalToConstant: height).isActive = true

        self.cardsGroupCVC = cardsGroupCVC
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(_ cards: [Card]) {
        
    }

}

