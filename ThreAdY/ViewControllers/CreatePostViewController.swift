//
//  CreatePostViewController.swift
//  ThreAdY
//
//  Created by Adrian Yu on 23/08/24.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var TFContentType: UITextField!
    @IBOutlet weak var TVContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func BtnCreateOnClick(_ sender: Any) {
        let contentType = TFContentType.text!
        let content = TVContent.text!
    
        let currentUsername = SessionHelper.shared.getUsername()!
        let currentUser = UserService.shared.getUser(username: currentUsername).payload as! User
        let response = PostService.shared.createPost(content: content, contentType: contentType, uploadedAt: Date(), user: currentUser)
        
        if response.isSuccess {
            NavigationService.shared.navigate(to: .home, from: self)
            return
        }
        
        AlertHelper.shared.alert(title: "Error", message: response.message, on: self)
    }
    
}
