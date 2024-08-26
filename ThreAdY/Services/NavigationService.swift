//
//  NavigationService.swift
//  ThreAdY
//
//  Created by Adrian Yu on 21/08/24.
//

import Foundation
import UIKit

class NavigationService {
    
    static let shared = NavigationService()
    
    private init(){}

    func navigate(to pageDestination: PageDestination, from currentViewController: UIViewController){
        
        let storyboard = currentViewController.storyboard
        var viewControllerToPush: UIViewController?
        let transition = CATransition()
        
        switch pageDestination {
            case .register:
                viewControllerToPush = storyboard?.instantiateViewController(withIdentifier: "RegisterView") as? RegisterViewController
                transition.duration = 0.5
                transition.type = .push
                transition.subtype = .fromLeft
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                break
                
            case .login:
                viewControllerToPush = storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController
                transition.duration = 0.5
                transition.type = .push
                transition.subtype = .fromRight
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                break
                
            case .home:
                viewControllerToPush = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController
                transition.duration = 0.5
                transition.type = .fade
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                break
                
            case .createPost:
                viewControllerToPush = storyboard?.instantiateViewController(withIdentifier: "CreatePostView") as? CreatePostViewController
                transition.duration = 0.5
                transition.type = .fade
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                break
            
            case .updatePost(let post):
                let updateVC = storyboard?.instantiateViewController(withIdentifier: "UpdatePostView") as! UpdatePostViewController
                updateVC.post = post
                viewControllerToPush = updateVC
                transition.duration = 0.5
                transition.type = .fade
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                break
                
            case .profile:
                viewControllerToPush = storyboard?.instantiateViewController(withIdentifier: "ProfileView") as? ProfileViewController
                transition.duration = 0.5
                transition.type = .fade
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                break
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = viewControllerToPush
            window.layer.add(transition, forKey: kCATransition)
            window.makeKeyAndVisible()
        }
        
    }
}

