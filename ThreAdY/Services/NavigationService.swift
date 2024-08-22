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
        
        switch pageDestination {
            case .register:
                viewControllerToPush = storyboard?.instantiateViewController(withIdentifier: "RegisterView") as? RegisterViewController
                break
                
            case .login:
                viewControllerToPush = storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController
                break
        }
        
        
        currentViewController.navigationController?.pushViewController(viewControllerToPush!, animated: true)
    }
}

