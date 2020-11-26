
import UIKit

class CardsGroupCVC: UICollectionViewController {
    
    private var viewModel = CardsVM()
    
    
    private var widthCell: CGFloat = {
        return UIScreen.main.bounds.width/3.6
    }()

    private var heightCell: CGFloat = {
        return UIScreen.main.bounds.width/3.6 * 0.7
    }()

    private lazy var navBarTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    // MARK: - Lifecycle
    override func loadView() {
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(width: widthCell, height: heightCell)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardGroupCVCell.self, forCellWithReuseIdentifier: CardGroupCVCell.identifier)
        collectionView.register(CardCVCell.self, forCellWithReuseIdentifier: CardCVCell.identifier)
        
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = true
        collectionView.isPagingEnabled = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delaysContentTouches = false
        collectionView.isScrollEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor =
            UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 57/255, green: 7/255, blue: 76/255, alpha: 1)
                default:
                    return UIColor.white
                }
            }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.viewModel.completionHandler = { [weak self] in
            guard let self = self else {return}
            var suffix = "карт"
            let count = self.viewModel.objects().count%5
            if count == 1 {
                suffix = "карта"
            } else {
                suffix = "карты"
            }
            
            self.navBarTitle.text = "В кошельке \(self.viewModel.objects().count) \(suffix)"
            
            self.setupView()
            self.collectionView.reloadData()
        }
        
        self.viewModel.getObjects()
    }
    
    // MARK: - Setups
    private func setupView() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.collectionView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.backgroundView = blurEffectView
        self.collectionView.layer.cornerRadius = 16

        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navBarTitle)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.favorites().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCVCell.identifier, for: indexPath) as? CardCVCell {
            let item = viewModel.favorites()[indexPath.row]
            cell.prepare(item)
            
            return cell
        }

        return UICollectionViewCell()

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let card = viewModel.favorites()[indexPath.row]
        let detailVC = DetailCardVC(card: card)
        self.present(detailVC, animated: true, completion: nil)
    }
    
    
}

