//
//  RegisterViewController.swift
//  ThreAdY
//
//  Created by Adrian Yu on 20/08/24.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var TFUsername: UITextField!
    @IBOutlet weak var TFPassword: UITextField!
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func BtnSignUpOnClick(_ sender: Any) {
        let username = TFUsername.text!
        let password = TFPassword.text!
        
        let response = UserService.shared.register(username: username, password: password)
        if !response.isSuccess {
            AlertHelper.shared.alert(title: "Error", message: response.message, on: self)
            return
        }

        NavigationService.shared.navigate(to: .login, from: self)
        
        AlertHelper.shared
            .alert(title: "Success", message: response.message, on: self)
    }
    
    @IBAction func BtnSignInOnClick(_ sender: Any) {
        NavigationService.shared.navigate(to: .login, from: self)
    }
}
