//
//  UserService.swift
//  ThreAdY
//
//  Created by Adrian Yu on 21/08/24.
//

import Foundation
import CoreData
import UIKit

class UserService {
    
    static let shared = UserService()
    
    private var context: NSManagedObjectContext!
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func register(username: String, password: String) -> Response {
        if username.isEmpty {
            return Response(isSuccess: false, message: "Username can't be empty.", payload: nil)
        }
                            
        if password.isEmpty {
            return Response(isSuccess: false, message: "Password can't be empty.", payload: nil)
        }
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let result = try context.fetch(fetchRequest)
            if !result.isEmpty {
                return Response(isSuccess: false, message: "Username already exists.", payload: nil)
            }
            
            let user = User(context: context)
            user.username = username
            user.password = password
            
            try context.save()
            
            return Response(isSuccess: true, message: "Successfully registered user.", payload: user)
        } catch {
            return Response(isSuccess: false, message: "Failed to register user.", payload: nil)
        }
    }
        
    func login(username: String, password: String) -> Response {
        if username.isEmpty {
            return Response(isSuccess: false, message: "Username can't be empty.", payload: nil)
        }
                            
        if password.isEmpty {
            return Response(isSuccess: false, message: "Password can't be empty.", payload: nil)
        }
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let result = try context.fetch(fetchRequest)
            
            if result.isEmpty {
                return Response(isSuccess: false, message: "Invalid username or password.", payload: nil)
            }
            
            let user = result.first!
            
            return Response(isSuccess: true, message: "Successfully logged in user.", payload: user)
        } catch {
            return Response(isSuccess: false, message: "Failed to log in.", payload: nil)
        }
    }
    
}
