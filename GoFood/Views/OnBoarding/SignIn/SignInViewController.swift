//
//  SignInViewController.swift
//  GoFood
//
//  Created by Sagar Das on 20/09/23.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    //MARK: - LiyeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backBtn"), style: .plain, target: self, action: #selector(leftButtonTapped))
        setupNavigationBar()
    }
    
    
    
    //MARK: -Helper
    
    func setupNavigationBar() {
        // Create a custom view to hold the button
               let customView = UIView()
        
               // Create a button with your image
               let backButton = UIButton()
               backButton.setImage(UIImage(named: "backBtn"), for: .normal)
               backButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)

               // Add the button to the custom view
               customView.addSubview(backButton)

               // Add constraints to the button and custom view
               customView.translatesAutoresizingMaskIntoConstraints = false
               backButton.translatesAutoresizingMaskIntoConstraints = false

               NSLayoutConstraint.activate([
                   backButton.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
                   backButton.topAnchor.constraint(equalTo: customView.topAnchor),
                   backButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
                   backButton.bottomAnchor.constraint(equalTo: customView.bottomAnchor),

                   customView.widthAnchor.constraint(equalToConstant: 44), // Adjust the width as needed
                   customView.heightAnchor.constraint(equalToConstant: 44) // Adjust the height as needed
               ])

               // Assign the custom view as the left bar button item
               navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
    }
    

    
    //MARK: -Selector
    
    @objc func leftButtonTapped() {
           print("Left button tapped!")
        let controller = storyboard?.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
       }
    
    
    /// performing Authentication
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        
        guard let email = emailTxtField.text, !email.isEmpty,
              let password = passwordTxtField.text, !password.isEmpty else {
            print("textfield is empty")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) {[weak self] result, error in
            
            guard let strongSelf = self else {
                return
            }
            guard error == nil else {
                print("authentication error")
                return
            }
            print(" You have signin successfully")
            self?.performSegue(withIdentifier: "signin", sender: self)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let homeVC  = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            homeVC.modalTransitionStyle = .flipHorizontal
//            homeVC.modalPresentationStyle = .fullScreen
//            self?.present(homeVC, animated: true)
            
//            let controller = self?.storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UITabBarController
//            controller.modalPresentationStyle = .fullScreen
//            controller.modalTransitionStyle = .partialCurl
//            self!.present(controller, animated: true)
//

            
        }
    }
    

}
