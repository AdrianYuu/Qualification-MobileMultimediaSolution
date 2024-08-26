//
//  ProfileViewController.swift
//  ThreAdY
//
//  Created by Adrian Yu on 23/08/24.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var LblUsername: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsernameLabel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setUsernameLabel(){
        LblUsername.text = "Hello, " + SessionHelper.shared.getUsername()! + "!"
    }
    
    @IBAction func BtnSignOutOnClick(_ sender: Any) {
        SessionHelper.shared.logout()
        NavigationService.shared.navigate(to: .login, from: self)
    }

}
