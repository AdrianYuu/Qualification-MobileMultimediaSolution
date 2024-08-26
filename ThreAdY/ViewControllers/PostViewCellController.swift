//
//  PostViewCellController.swift
//  ThreAdY
//
//  Created by Adrian Yu on 26/08/24.
//

import UIKit

protocol PostViewCellDelegate: AnyObject {
    func editButtonTapped(for post: Post)
}

class PostViewCellController: UITableViewCell {

    @IBOutlet weak var LblUsername: UILabel!
    @IBOutlet weak var LblContentType: UILabel!
    @IBOutlet weak var LblContent: UILabel!
    @IBOutlet weak var LblUploadedAt: UILabel!
    
    weak var delegate: PostViewCellDelegate?
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func BtnEditOnClick(_ sender: Any) {
        delegate?.editButtonTapped(for: post)
    }
}
