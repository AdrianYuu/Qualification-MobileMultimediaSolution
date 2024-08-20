//
//  UserService.swift
//  ThreAdY
//
//  Created by Adrian Yu on 20/08/24.
//

import Foundation
import UIKit
import CoreData

class UserService {
    
    static func saveUserToCoreData(name: String, email: String, password: String, context: NSManagedObjectContext, storyboard: UIStoryboard, navigationController: UINavigationController?, completion: @escaping (Bool, String?) -> Void) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        
        newUser.setValue(name, forKey: "name")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        newUser.setValue("user", forKey: "role")
        newUser.setValue(2000000, forKey: "balance")
        
        do {
            try context.save()
            
            // Navigate to login view
            if let nextPage = storyboard.instantiateViewController(withIdentifier: "loginView") as? LoginViewController {
                navigationController?.pushViewController(nextPage, animated: true)
                completion(true, "Registration Successful. You can log in using your account now.")
            }
        } catch {
            completion(false, "Failed to save user data.")
        }
    }
    
    static func getUsers(onSuccess: (([NSManagedObject]) -> Void)?, onFailure: ((String) -> Void)?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            onFailure?("Unable to access AppDelegate.")
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")

        do {
            let users = try managedContext.fetch(fetchRequest)
            onSuccess?(users)
        } catch let error as NSError {
            onFailure?("Could not fetch. \(error), \(error.userInfo)")
        }
    }

}
