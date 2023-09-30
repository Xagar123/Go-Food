//
//  SignUpViewController.swift
//  GoFood
//
//  Created by Sagar Das on 20/09/23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    
    
    //MARK: - Helper
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
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        
        guard let email = emailTxtField.text, !email.isEmpty,
              let password = passwordTxtField.text, !password.isEmpty else {
            print("missing field data")
            return
        }
        
        ///geting auth instance
        ///attempt to sign in
        ///if fail show alert

        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else {
                return
            }
            guard error == nil else {
                print("Account creation failed")
                return
            }
            print("Account creation successfull")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "GetStartedViewController") as! GetStartedViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.present(controller, animated: true)
            
        }
    }
    
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    


}
