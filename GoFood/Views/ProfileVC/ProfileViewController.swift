//
//  ProfileViewController.swift
//  GoFood
//
//  Created by Sagar Das on 26/09/23.
//

import UIKit
import FirebaseAuth


enum ProfileOption {
    case MyProfile
    case ChangePassword
    case MyVoucher
    case Notification
    case AboutUs
    case ContactUs
    
    var description: String {
        switch self {
        case .MyProfile: return "My Profile"
        case .ChangePassword: return "Change Password"
        case .MyVoucher: return "My Voucher"
        case .Notification: return "Notification"
        case .AboutUs: return "About Us"
        case .ContactUs: return "Contact Us"
        }
    }
}


class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var profileOption = ["My Profile","Change Password","My Voucher","Notification","About Us","Contact Us"]
   
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
    }
    

    func registerCell() {
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
   
    
    //MARK: - Helper
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

//MARK: - TableView Delegate & DataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
//        cell.profileOptionlbl.text = profileOption[indexPath.row]
        let profileOption: ProfileOption
        switch indexPath.row {
        case 0:
            profileOption = .MyProfile
        case 1:
            profileOption = .ChangePassword
        case 2:
            profileOption = .MyVoucher
        case 3:
            profileOption = .Notification
        case 4:
            profileOption = .AboutUs
        case 5:
            profileOption = .ContactUs
        default:
            fatalError("Invalid row")
        }
        
        cell.profileOptionlbl.text = profileOption.description
        
        cell.nextButtonCallBack = {
            print("next btn tapped")
            let profileOption: ProfileOption
            switch indexPath.row {
            case 0:
                profileOption = .MyProfile
                print("my profile action")
            case 1:
                profileOption = .ChangePassword
                print("change password action")
            case 2:
                profileOption = .MyVoucher
                print("my vouchre action")
            case 3:
                profileOption = .Notification
                print("notification action")
            case 4:
                profileOption = .AboutUs
                print("about us action")
            case 5:
                profileOption = .ContactUs
                print("contact us action")
            default:
                fatalError("Invalid row")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self)?.first as? ProfileHeaderView else { return UIView()}
        headerView.userName.text = "Virat Kohli"
        headerView.userNumber.text = "+91 123456789"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
