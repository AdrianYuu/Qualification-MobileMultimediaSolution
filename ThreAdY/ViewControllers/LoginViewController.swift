//
//  LoginViewController.swift
//  ThreAdY
//
//  Created by Adrian Yu on 20/08/24.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    var context: NSManagedObjectContext!

    @IBOutlet weak var TFUsername: UITextField!
    @IBOutlet weak var TFPassword: UITextField!
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction func BtnLoginOnClick(_ sender: Any) {
        let username = TFUsername.text!
        let password = TFPassword.text!
        
        if(username.isEmpty){
            AlertHelper.alert(title: "Error", message: "Username is required.", on: self)
            return
        }
        
        if(password.isEmpty){
            AlertHelper.alert(title: "Error", message: "Password is required.", on: self)
            return
        }
    }
    
}
