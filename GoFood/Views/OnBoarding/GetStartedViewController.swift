//
//  GetStartedViewController.swift
//  GoFood
//
//  Created by Sagar Das on 20/09/23.
//

import UIKit

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func getStartedBtnTapped(_ sender: UIButton) {
        print(" You have signin successfully")
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeVC  = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        homeVC.modalTransitionStyle = .flipHorizontal
//        homeVC.modalPresentationStyle = .fullScreen
//        self.present(homeVC, animated: true)
        self.performSegue(withIdentifier: "signin", sender: self)
        
    }
    

}
