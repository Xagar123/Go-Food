//
//  HomeViewController.swift
//  GoFood
//
//  Created by Sagar Das on 20/09/23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController, UISearchBarDelegate {

    //MARK: -Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let placeholderTexts = ["Search Biryani","Search Fried Rice","Search Pizza","Search Rolls","Search Burger","Search Chicken","Search Thali","Search Noodles","Search North Indian","Search Paeatha"]
    
    var totalSection = ["Delivery","Order Now!","RECOMMENDED","YOUR MIND?"]
    
    var orderBanner:[OrderBanner] = []
    enum RowType {
        case type2
        case type3
        case type4
    }
    
    var placeholderLabel: UILabel!
    var currentIndex = 0
    var timer: Timer?
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    
        registerCell()
        setupPlaceholderLbl()
        setupNavigationBar()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            view.addGestureRecognizer(tapGesture)
        
        orderBanner = [
            .init(bannerImage: "banner1", bannerTitle: "Chicken Biryani", discount: "Discount 40%"),
            .init(bannerImage: "banner2", bannerTitle: "Chicken Pizza", discount: "Discount 60%"),
            .init(bannerImage: "banner3", bannerTitle: "Broasted Chicken Hut", discount: "Discount 50%"),
        ]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    //MARK: - Helper
    func setupPlaceholderLbl() {
        // Create a custom label for the placeholder text
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.systemFont(ofSize: 17.0)
        placeholderLabel.textColor = UIColor.lightGray
        searchBar.addSubview(placeholderLabel)
        
        // Position the custom label like the default placeholder text
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: searchBar.layoutMarginsGuide.leadingAnchor,constant: 30),
            placeholderLabel.trailingAnchor.constraint(equalTo: searchBar.layoutMarginsGuide.trailingAnchor),
            placeholderLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor)
        ])
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updatePlaceholder), userInfo: nil, repeats: true)
        
        updatePlaceholder()
        startAnimationTimer()
        
    }
    
    func registerCell() {
        ///registering delivery cell
        tableView.register(UINib(nibName: "DeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: "DeliveryTableViewCell")
        
        ///registering TableCollectionCell
        tableView.register(UINib(nibName: TableCollectionViewCell.identifier, bundle: nil), forCellReuseIdentifier: TableCollectionViewCell.identifier)
    }

    func setupNavigationBar() {
        // Create a custom view to hold the button
        let customView = UIView()
        
        // Create a button with your image
        let profileBtn = UIButton()
        profileBtn.setImage(UIImage(named: "profile"), for: .normal)
        profileBtn.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        // Add the button to the custom view
        customView.addSubview(profileBtn)
        
        // Add constraints to the button and custom view
        customView.translatesAutoresizingMaskIntoConstraints = false
        profileBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileBtn.leadingAnchor.constraint(equalTo: customView.leadingAnchor),
            profileBtn.topAnchor.constraint(equalTo: customView.topAnchor,constant: 0),
            profileBtn.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
            profileBtn.bottomAnchor.constraint(equalTo: customView.bottomAnchor,constant: 40),
            
            customView.widthAnchor.constraint(equalToConstant: 60),
            customView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView)
    }
    
    //MARK: - Selector
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        ///hiding keyboard when ever user taped anywhere in screen
        view.endEditing(true)
    }
    
    
    @objc func rightButtonTapped() {
        print("profile btn tapped")
        let selectedTabBar = 3
        if selectedTabBar < tabBarController?.viewControllers?.count ?? 0 {
            tabBarController?.selectedIndex = selectedTabBar
        }
       }
    
    @objc func updatePlaceholder() {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .push
        animation.subtype = .fromTop
        animation.duration = 0.5
        
        // Apply the animation to the custom placeholder label
        placeholderLabel.layer.add(animation, forKey: "changePlaceholder")
        
        placeholderLabel.text = placeholderTexts[currentIndex]
        currentIndex = (currentIndex + 1) % placeholderTexts.count
    }

    
    //MARK: -SearchBar delegate
    deinit {
        // Invalidate the timer when the view controller is deallocated
        timer?.invalidate()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // User has started typing, stop the animation timer
        stopAnimationTimer()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // User has finished typing, resume the animation timer
        startAnimationTimer()
        
        // Deselect the search bar and hide the keyboard
        searchBar.resignFirstResponder()
    }
    
    private func startAnimationTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updatePlaceholder), userInfo: nil, repeats: true)
        updatePlaceholder()
    }
    
    private func stopAnimationTimer() {
        timer?.invalidate()
        timer = nil
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
