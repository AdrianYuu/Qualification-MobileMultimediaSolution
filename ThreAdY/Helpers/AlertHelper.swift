//
//  AlertHelper.swift
//  ThreAdY
//
//  Created by Adrian Yu on 20/08/24.
//

import Foundation
import UIKit

class AlertHelper {
    
    static func alert(title: String, message: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
    
}
