//
//  UpdatePostViewController.swift
//  ThreAdY
//
//  Created by Adrian Yu on 26/08/24.
//

import UIKit

class UpdatePostViewController: UIViewController {
    
    @IBOutlet weak var TFContentType: UITextField!
    @IBOutlet weak var TVContent: UITextView!
    
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPost()
    }
    
    func fetchPost(){
        TFContentType.text = post.contentType
        TVContent.text = post.content
    }

    @IBAction func BtnUpdateOnClick(_ sender: Any) {
        let contentType = TFContentType.text!
        let content = TVContent.text!
        
        let response = PostService.shared.updatePost(post: post, newContent: content, newContentType: contentType)
        
        if response.isSuccess {
            NavigationService.shared.navigate(to: .home, from: self)
            return
        }
        
        AlertHelper.shared.alert(title: "Error", message: response.message, on: self)
    }
    
}
