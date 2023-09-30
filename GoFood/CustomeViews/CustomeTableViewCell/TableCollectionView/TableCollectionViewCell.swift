//
//  TableCollectionViewCell.swift
//  GoFood
//
//  Created by Sagar Das on 27/09/23.
//

import UIKit

class TableCollectionViewCell: UITableViewCell {

    //MARK: - Properties
    static let identifier = String(describing: TableCollectionViewCell.self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    var cellType: HomeViewController.RowType = .type2
    var autoScrollTimer: Timer?
    
    var orderBanner:[OrderBanner] = []
    
    //MARK: -Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCollectionView(withType type: HomeViewController.RowType) {
        cellType = type
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.isPagingEnabled = true
        
        self.collectionView.register(UINib(nibName: BannerCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCollectionCell.identifier)
        
        self.collectionView.register(UINib(nibName: "RecommendedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommendedCollectionViewCell")
        
        ///registering whats on your mind cell
        self.collectionView.register(UINib(nibName: "ItemsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemsCollectionViewCell")
        
        // Customize the collection view layout if needed
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    func configureData(with model:[OrderBanner]) {
        self.orderBanner = model
    }
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScrollBanner), userInfo: nil, repeats: true)
    }

    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }

    @objc func autoScrollBanner() {
//        let contentOffset = collectionView.contentOffset
//        let nextPage = IndexPath(item: Int(contentOffset.x / collectionView.frame.width) + 1, section: 0)
//        collectionView.scrollToItem(at: nextPage, at: .left, animated: true)
    }


}

//MARK: - Collection View Delegate & DataSource
extension TableCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
            
        case .type2:
            return 3
        case .type3:
            return 10
        case .type4:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch cellType {
        case .type2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.identifier, for: indexPath) as? BannerCollectionCell
            startAutoScroll()
            cell?.configureWithModel(with: orderBanner[indexPath.row])
            return cell!
            
        case .type3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedCollectionViewCell", for: indexPath) as? RecommendedCollectionViewCell
            
            return cell!
        case .type4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsCollectionViewCell", for: indexPath) as? ItemsCollectionViewCell
            
            return cell!
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        switch cellType {
        case .type2:
            return CGSize(width: collectionView.frame.width, height: 180)
        case .type3:
            return CGSize(width: collectionView.frame.width / 2, height: 80)
        case .type4:
            return CGSize(width: (collectionView.frame.width / 3), height: 96)
        default:
            return CGSize(width: 90, height: 90)
        }
    }
    
    
}
