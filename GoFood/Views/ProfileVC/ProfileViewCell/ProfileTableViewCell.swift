//
//  ProfileTableViewCell.swift
//  GoFood
//
//  Created by Sagar Das on 05/10/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileOptionlbl: UILabel!
    var nextButtonCallBack: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    @IBAction func nextbtnTapped(_ sender: UIButton) {
        nextButtonCallBack?()
    }
   
    
    
}
