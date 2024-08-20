//
//  RegisterViewController.swift
//  ThreAdY
//
//  Created by Adrian Yu on 20/08/24.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
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
    
    @IBAction func BtnRegisterOnClick(_ sender: Any) {
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
        
        createUser(username: username, password: password)
    }
    
    func createUser(username: String, password: String) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
        let user = NSManagedObject(entity: entity, insertInto: context)
        
        user.setValue(username, forKey: "username")
        user.setValue(password, forKey: "password")
    
        do {
            try context.save()
            
            if let nextPage = storyboard?.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController {
                self.navigationController?.pushViewController(nextPage, animated: true)
                AlertHelper.alert(title: "Registration Successful", message: "You can login using your account.", on: self)
            }
            
        } catch {
            AlertHelper.alert(title: "Error", message: "Failed to save.", on: self)
        }
    }

}
