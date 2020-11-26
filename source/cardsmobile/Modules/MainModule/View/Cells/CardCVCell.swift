
import UIKit
import SDWebImage

class CardCVCell: BaseCollectionViewCell {
    
    static let identifier = "CardCVCell"
    
    private lazy var coverView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var darkView: DarkViewGradient = {
        let darkView = DarkViewGradient()
        darkView.clipsToBounds = true
        darkView.layer.cornerRadius = 8
        return darkView
    }()
    
    private lazy var shadowView: RoundShadowView = {
        let view = RoundShadowView()
        return view
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var kindLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        return label
    }()
    
    private lazy var issuerLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textColor = .black
        label.font =  UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    // MARK: - lifecycle
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width = UIScreen.main.bounds.width/3.18
        let height = width*0.7
        
        self.contentView.addSubview(shadowView)
        self.contentView.addSubview(coverView)
        coverView.addSubview(previewImageView)
        coverView.addSubview(darkView)
        coverView.addSubview(valueLabel)
        coverView.addSubview(kindLabel)
        //        coverView.addSubview(issuerLabel)
        //        coverView.addSubview(subtitleLabel)
        //        coverView.addSubview(subtitleLabel)
        
        coverView.translatesAutoresizingMaskIntoConstraints = false
        coverView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        coverView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        coverView.heightAnchor.constraint(equalToConstant: height - 8).isActive = true
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        shadowView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        shadowView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: height - 8).isActive = true
        
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.topAnchor.constraint(equalTo: coverView.topAnchor).isActive = true
        previewImageView.rightAnchor.constraint(equalTo: coverView.rightAnchor).isActive = true
        previewImageView.leftAnchor.constraint(equalTo: coverView.leftAnchor).isActive = true
        previewImageView.heightAnchor.constraint(equalToConstant: height - 8).isActive = true
        
        darkView.translatesAutoresizingMaskIntoConstraints = false
        darkView.topAnchor.constraint(equalTo: coverView.topAnchor).isActive = true
        darkView.rightAnchor.constraint(equalTo: coverView.rightAnchor).isActive = true
        darkView.leftAnchor.constraint(equalTo: coverView.leftAnchor).isActive = true
        darkView.heightAnchor.constraint(equalToConstant: height - 8).isActive = true
        
        kindLabel.translatesAutoresizingMaskIntoConstraints = false
        kindLabel.bottomAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: -8).isActive = true
        kindLabel.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 8).isActive = true
        
        //        issuerLabel.translatesAutoresizingMaskIntoConstraints = false
        //        issuerLabel.topAnchor.constraint(equalTo: kindLabel.bottomAnchor, constant: 8).isActive = true
        //        issuerLabel.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 16).isActive = true
        //
        //        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        //        subtitleLabel.topAnchor.constraint(equalTo: kindLabel.bottomAnchor, constant: 8).isActive = true
        //        subtitleLabel.leftAnchor.constraint(equalTo: issuerLabel.rightAnchor, constant: 8).isActive = true
        //        subtitleLabel.rightAnchor.constraint(equalTo: coverView.rightAnchor, constant: -16).isActive = true
        //
        //        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        //        valueLabel.topAnchor.constraint(equalTo: issuerLabel.bottomAnchor, constant: 8).isActive = true
        //        valueLabel.leftAnchor.constraint(equalTo: coverView.leftAnchor, constant: 16).isActive = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.kindLabel.text = ""
        self.issuerLabel.text = ""
        self.subtitleLabel.text = ""
        self.valueLabel.text = ""
        self.previewImageView.image = nil
    }
    
    func prepare(_ card: Card) {
        
        self.kindLabel.text = card.kind
        self.issuerLabel.text = card.issuer.name
        if card.kind == "certificate", let certificate = card.certificate {
            self.subtitleLabel.text = certificate.expireDate
            self.valueLabel.text = "₽ \(certificate.value)"
            self.kindLabel.text = "до \(certificate.expireDate.date)"
        }
        if card.kind == "loyalty", let loyaltyCard = card.loyaltyCard {
            self.subtitleLabel.text = loyaltyCard.grade
            self.valueLabel.text = "₽\(loyaltyCard.balance)"
            self.kindLabel.text = loyaltyCard.grade
        }
                
        if let url = URL(string: card.texture.front) {
            //self.previewImageView.load(url: url)
            self.previewImageView.sd_setImage(with: url, completed: nil)
        }
        
    }

}
