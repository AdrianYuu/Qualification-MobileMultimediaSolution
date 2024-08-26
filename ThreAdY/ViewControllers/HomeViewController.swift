//
//  HomeViewController.swift
//  ThreAdY
//
//  Created by Adrian Yu on 23/08/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TVPost: UITableView!
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        TVPost.delegate = self
        TVPost.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TVPost.dequeueReusableCell(withIdentifier: "PostViewCell") as! PostViewCellController
        
        let post = posts[indexPath.row]
        cell.post = post
        cell.delegate = self
        
        
        cell.LblUsername.text = "@" + (post.user?.username)!
        cell.LblContentType.text = post.contentType
        cell.LblContent.text = post.content
        
        let uploadedAt = post.uploadedAt!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm a"
        let formattedDate = dateFormatter.string(from: uploadedAt)
        
        cell.LblUploadedAt.text = formattedDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let postToDelete = posts[indexPath.row]
            
            posts.remove(at: indexPath.row)
            
            let response = PostService.shared.deletePost(post: postToDelete)
            
            if response.isSuccess {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func fetchPosts(){
        posts = PostService.shared.getPosts()
    }
}

extension HomeViewController: PostViewCellDelegate {
    func editButtonTapped(for post: Post) {
        
        let currentUsername = SessionHelper.shared.getUsername()!
        let user = UserService.shared.getUser(username: currentUsername).payload as! User
        
        if post.user != user {
            AlertHelper.shared.alert(title: "Error", message: "Unauthorized", on: self)
            return
        }
        
        NavigationService.shared.navigate(to: .updatePost(post: post), from: self)
    }
}
