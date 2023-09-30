//
//  SceneDelegate.swift
//  GoFood
//
//  Created by Sagar Das on 19/09/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let sceneWindow = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: sceneWindow)
        
        if Auth.auth().currentUser != nil {
            print("user is login")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let homeVC  = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            window?.rootViewController = homeVC
            if let controller = storyboard.instantiateViewController(withIdentifier: "HomeNC") as? UITabBarController {
                // Safe to use controller here
                print("view loaded succesfully")
                window?.rootViewController = controller
            } else {
                // Handle the case where the view controller could not be instantiated
                print("error appear while loading screen")
            }
            window?.makeKeyAndVisible()
            
        }else {
            print("user is not login to our app")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let getStartedScreen = storyboard.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
            window?.rootViewController = getStartedScreen
            
        }
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

