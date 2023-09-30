//
//  OnBoardingCollectionViewCell.swift
//  GoFood
//
//  Created by Sagar Das on 19/09/23.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnBoardingCollectionViewCell.self)
    
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var sliderLbl: UILabel!
    @IBOutlet weak var sliderDescription: UILabel!
    
    func setup(_ slides: OnBoardingSlide){
        self.sliderDescription.text = slides.description
        self.sliderLbl.text = slides.title
        self.sliderImageView.image = slides.image
    }
    
    
    
}
