//
//  ForgotPasswordViewController.swift
//  GoFood
//
//  Created by Sagar Das on 20/09/23.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigationBar()
    }
    
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
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            // Handle empty email field error
            return
        }

        sendPasswordResetEmail(for: email) { error in
            if let error = error {
                // Handle the error, e.g., show an alert to the user
                print("Password reset failed with error: \(error.localizedDescription)")
            } else {
                // Password reset email sent successfully
                print("Password reset email sent successfully")
            }
        }
    }
    
    func sendPasswordResetEmail(for email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
}
