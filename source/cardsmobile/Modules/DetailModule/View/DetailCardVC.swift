import UIKit
import SDWebImage

class DetailCardVC: UIViewController {

    private var viewModel: DetailModuleDelegate!
    
    var frontPreviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    var backPreviewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.isUserInteractionEnabled = true
        imageView.alpha = 0
        return imageView
    }()

    var barcodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var additionalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var additionalTextView: UITextView = {
        let textView = UITextView(frame: CGRect.zero)
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.isEditable = false
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.isHidden = true
        return textView
    }()
        
    convenience init(card: Card) {
        self.init()
        self.viewModel = DetailCardVM(card: card)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let textColor =
            UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor.white
                default:
                    return UIColor.black
                }
            }

        let foregroundColor =
            UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor.white
                default:
                    return UIColor(red: 57/255, green: 7/255, blue: 176/255, alpha: 1)
                }
            }

        self.view.backgroundColor =
            UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 57/255, green: 7/255, blue: 76/255, alpha: 1)
                default:
                    return UIColor.white
                }
            }
        
        self.additionalTextView.textColor = textColor

        self.additionalTextView.linkTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: foregroundColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.setupValues()
    }
    
    func setupView() {
        let width = UIScreen.main.bounds.width
        let height = width*0.6

        self.view.addSubview(frontPreviewImageView)
        frontPreviewImageView.translatesAutoresizingMaskIntoConstraints = false
        frontPreviewImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        frontPreviewImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        frontPreviewImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        frontPreviewImageView.heightAnchor.constraint(equalToConstant: height).isActive = true

        self.view.addSubview(backPreviewImageView)
        backPreviewImageView.translatesAutoresizingMaskIntoConstraints = false
        backPreviewImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        backPreviewImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        backPreviewImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        backPreviewImageView.heightAnchor.constraint(equalToConstant: height).isActive = true

        self.view.addSubview(barcodeImageView)
        barcodeImageView.translatesAutoresizingMaskIntoConstraints = false
        barcodeImageView.topAnchor.constraint(equalTo: frontPreviewImageView.bottomAnchor, constant: 16).isActive = true
        barcodeImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        barcodeImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        barcodeImageView.heightAnchor.constraint(equalToConstant: height/2).isActive = true

        self.view.addSubview(additionalLabel)
        additionalLabel.translatesAutoresizingMaskIntoConstraints = false
        additionalLabel.topAnchor.constraint(equalTo: barcodeImageView.bottomAnchor, constant: 16).isActive = true
        additionalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        additionalLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true

        self.view.addSubview(additionalTextView)
        additionalTextView.translatesAutoresizingMaskIntoConstraints = false
        additionalTextView.topAnchor.constraint(equalTo: additionalLabel.bottomAnchor, constant: 16).isActive = true
        additionalTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        additionalTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true

        let tapFront = UITapGestureRecognizer(target: self, action: #selector(frontCardTapped(_ :)))
        frontPreviewImageView.addGestureRecognizer(tapFront)
        frontPreviewImageView.isUserInteractionEnabled = true

        let tapBack = UITapGestureRecognizer(target: self, action: #selector(backCardTapped(_ :)))
        backPreviewImageView.addGestureRecognizer(tapBack)
        backPreviewImageView.isUserInteractionEnabled = true

    }
    
    func setupValues() {
        
        if let url = self.viewModel.getFrontPreviewImageUrl() {
            self.frontPreviewImageView.sd_setImage(with: url, completed: nil)
            //self.frontPreviewImageView.load(url: url)
        }

        if let url = self.viewModel.getBackPreviewImageUrl() {
            self.backPreviewImageView.sd_setImage(with: url, completed: nil)
            //self.backPreviewImageView.load(url: url)
        }

        self.viewModel.generateBarcode { [weak self ](image) in
            DispatchQueue.main.async {
                self?.barcodeImageView.image = image
            }
        }
        
        self.additionalLabel.text = self.viewModel.getAdditionalIbfoText()
//        self.viewModel.getTextFront { [weak self] (text) in
//            guard let self = self else {return}
//            DispatchQueue.main.async {
//                if let text = text {
//                    self.additionalTextView.text = text
//                    self.additionalTextView.isHidden = false
//                } else {
//                    self.additionalTextView.isHidden = true
//                }
//            }
//
//        }
    }
 
    // MARK: - Actions
    @objc func frontCardTapped(_ gesture: UITapGestureRecognizer) {

        UIView.animate(withDuration: 0.3) {
            self.frontPreviewImageView.alpha = 0
            self.backPreviewImageView.alpha = 1
        } completion: { (finish) in
            
//            self.viewModel.getTextBack { [weak self] (text) in
//                guard let self = self else {return}
//                DispatchQueue.main.async {
//                    if let text = text {
//                        self.additionalTextView.text = text
//                        self.additionalTextView.isHidden = false
//                    } else {
//                        self.additionalTextView.isHidden = true
//                    }
//                }
//
//            }
        }

     }

    @objc func backCardTapped(_ gesture: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.3) {
            self.frontPreviewImageView.alpha = 1
            self.backPreviewImageView.alpha = 0
        } completion: { (finish) in
//            self.viewModel.getTextFront { [weak self] (text) in
//                guard let self = self else {return}
//                DispatchQueue.main.async {
//                    if let text = text {
//                        self.additionalTextView.text = text
//                        self.additionalTextView.isHidden = false
//                    } else {
//                        self.additionalTextView.isHidden = true
//                    }
//                }
//            }
        }
     }

}
