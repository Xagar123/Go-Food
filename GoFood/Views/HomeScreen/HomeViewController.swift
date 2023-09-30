//
//  HomeViewController.swift
//  GoFood
//
//  Created by Sagar Das on 20/09/23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var placeholderTimer: Timer?
    let placeholderTexts = ["Search Biryani","Search Fried Rice","Search Pizza","Search Rolls","Search Burger","Search Chicken","Search Thali","Search Noodles","Search North Indian","Search Paeatha"]
    var currentPlaceholderIndex = 0
    
    var totalSection = ["Delivery","Order Now!","RECOMMENDED","YOUR MIND?"]
    
    var orderBanner:[OrderBanner] = []
    enum RowType {
        case type2
        case type3
        case type4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        ///registering delivery cell
        tableView.register(UINib(nibName: "DeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliveryTableViewCell")
        
        ///registering TableCollectionCell
        tableView.register(UINib(nibName: TableCollectionViewCell.identifier, bundle: nil), forCellReuseIdentifier: TableCollectionViewCell.identifier)
     
//        ///registering header view
//        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "CustomHeaderView")

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            view.addGestureRecognizer(tapGesture)
        
        orderBanner = [
            .init(bannerImage: "banner1", bannerTitle: "Chicken Biryani", discount: "Discount 40%"),
            .init(bannerImage: "banner2", bannerTitle: "Chicken Pizza", discount: "Discount 60%"),
            .init(bannerImage: "banner3", bannerTitle: "Broasted Chicken Hut", discount: "Discount 50%"),
        ]
        searchBar.placeholder = placeholderTexts[currentPlaceholderIndex]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile"), style: .done, target: self, action: #selector(profileBtnTapped))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startPlaceholderTimer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopPlaceholderTimer()
    }

    func stopPlaceholderTimer() {
        placeholderTimer?.invalidate()
        placeholderTimer = nil
    }

    func startPlaceholderTimer() {
        placeholderTimer = Timer.scheduledTimer(timeInterval: 2.0,
                                               target: self,
                                               selector: #selector(rotatePlaceholders),
                                               userInfo: nil,
                                               repeats: true)
    }

    func animatePlaceholderChange() {
        UIView.transition(with: searchBar,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                              self.searchBar.placeholder = self.placeholderTexts[self.currentPlaceholderIndex]
                          },
                          completion: nil)
    }


    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        ///hiding keyboard when ever user taped anywhere in screen
        view.endEditing(true)
    }
    
    @objc func rotatePlaceholders() {
        currentPlaceholderIndex = (currentPlaceholderIndex + 1) % placeholderTexts.count
        animatePlaceholderChange()
    }
    
    @objc func profileBtnTapped() {
        let selectedTabBar = 3
        if selectedTabBar < tabBarController?.viewControllers?.count ?? 0 {
            tabBarController?.selectedIndex = selectedTabBar
        }
        
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return totalSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        
        default:
            return 0
        }
//        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeliveryTableViewCell", for: indexPath) as? DeliveryTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCollectionViewCell", for: indexPath) as? TableCollectionViewCell else {
                return UITableViewCell()
            }
            cell.configureCollectionView(withType: .type2)
            cell.configureData(with: orderBanner)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCollectionViewCell", for: indexPath) as? TableCollectionViewCell else { return UITableViewCell()}
            cell.configureCollectionView(withType: .type3)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCollectionViewCell", for: indexPath) as? TableCollectionViewCell else { return UITableViewCell()}
            cell.configureCollectionView(withType: .type4)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
          return 95
        case 1:
            return 135
        case 2:
            return 190
        case 3:
            return 220
        default:
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("CustomHeaderView", owner: self)?.first as? CustomHeaderView else { return UIView()}
        if section == 2 {
            headerView.headerTitle.text = "RECOMMENDED FOR YOU"
            return headerView
        }
        if section == 3 {
            headerView.headerTitle.text = "WHAT’S ON YOUR MIND?"
            return headerView
        }
       
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
        switch section {
        case 0:
            return 20
        case 2:
            return 50
        case 3:
            return 50
        default:
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    
}
