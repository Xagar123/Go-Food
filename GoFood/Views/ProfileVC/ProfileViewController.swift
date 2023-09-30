//
//  ProfileViewController.swift
//  GoFood
//
//  Created by Sagar Das on 26/09/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func signOutBtnTapped(_ sender: UIButton) {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            let stroyboard = UIStoryboard(name: "Main", bundle: nil)
            let getStartedScreen = stroyboard.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
//            self.navigationController?.pushViewController(getStartedScreen, animated: true)
            getStartedScreen.modalPresentationStyle = .fullScreen
            getStartedScreen.modalTransitionStyle = .crossDissolve
            self.present(getStartedScreen, animated: true)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    

}
