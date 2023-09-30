//
//  OnBoardingViewController.swift
//  GoFood
//
//  Created by Sagar Das on 19/09/23.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var colectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    
    var slider:[OnBoardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            if currentPage == slider.count - 1 {
                continueBtn.setTitle("Get Started", for: .normal)
            }else {
                continueBtn.setTitle("Continue", for: .normal)
            }
        }
    }
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        colectionView.delegate = self
        colectionView.dataSource = self
       
    }
    
    //MARK: -Helper
    
    func setup() {
        slider = [
            OnBoardingSlide(title: "All your favourite food", description: "Bringing Your Favorite Flavors to Your Fingertips!", image: UIImage(named: "slide1")!),
            OnBoardingSlide(title: "Get delivery at your doorstep", description: "Your Food Journey Starts at Your Doorstep with Us!", image: UIImage(named: "slide2")!),
        ]
    }
    
    @IBAction func continueBtnTapped(_ sender: UIButton) {
        
        if currentPage == slider.count - 1 {
            print("Go to login page")
            let controller = storyboard?.instantiateViewController(withIdentifier: "SigninNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            self.present(controller, animated: true)
           
        }else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            colectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        //move to sign up screen
        let controller = storyboard?.instantiateViewController(withIdentifier: "SigninNC") as! UINavigationController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
    }
    

}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as! OnBoardingCollectionViewCell
        cell.setup(slider[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    /// This method will triger when scroll will finish
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        self.colectionView.isPagingEnabled = true
    }
    
}
