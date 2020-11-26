
import UIKit

class CardsCVC: UICollectionViewController {
    
    private var viewModel = CardsVM()

    private var widthCell: CGFloat = {
        return UIScreen.main.bounds.width/3.3
    }()

    private var heightCell: CGFloat = {
        return UIScreen.main.bounds.width/3.3 * 0.7
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardGroupCVCell.self, forCellWithReuseIdentifier: CardGroupCVCell.identifier)
        collectionView.register(CardCVCell.self, forCellWithReuseIdentifier: CardCVCell.identifier)
        
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = true
        collectionView.isPagingEnabled = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delaysContentTouches = false
        
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
        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navBarTitle)
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return viewModel.objects().count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardGroupCVCell.identifier, for: indexPath) as? CardGroupCVCell {
                //let item = viewModel.objects[indexPath.row]
                //cell.prepare(item)
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCVCell.identifier, for: indexPath) as? CardCVCell {
                let item = viewModel.objects()[indexPath.row]
                cell.prepare(item)
                
                return cell
            }
        }
        return UICollectionViewCell()
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let card = viewModel.objects()[indexPath.row]
        let detailVC = DetailCardVC(card: card)
        self.present(detailVC, animated: true, completion: nil)
    }
    
}

extension CardsCVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: heightCell*3.4)
        } else {
            return CGSize(width: widthCell, height: heightCell)
        }
    }
}

