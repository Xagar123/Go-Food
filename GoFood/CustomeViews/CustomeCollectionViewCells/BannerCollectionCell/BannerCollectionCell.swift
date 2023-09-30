//
//  BannerCollectionCell.swift
//  GoFood
//
//  Created by Sagar Das on 27/09/23.
//

import UIKit

class BannerCollectionCell: UICollectionViewCell {
    
    static let identifier = String(describing: BannerCollectionCell.self)
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public  func configureWithModel(with model:OrderBanner) {
        self.bannerImage.image = UIImage(named: model.bannerImage)
        self.titleLbl.text = model.bannerTitle
        self.discountLbl.text = model.discount
    }
}
