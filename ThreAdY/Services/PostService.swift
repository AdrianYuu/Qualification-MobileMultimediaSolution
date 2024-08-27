//
//  PostService.swift
//  ThreAdY
//
//  Created by Adrian Yu on 26/08/24.
//

import Foundation
import CoreData
import UIKit


class PostService {
    
    static let shared = PostService()
    
    private var context: NSManagedObjectContext!
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func createPost(content: String, contentType: String, uploadedAt: Date, user: User) -> Response {
        if(content.isEmpty){
            return Response(isSuccess: false, message: "Content can't be empty.", payload: nil)
        }
        
        if(contentType.isEmpty){
            return Response(isSuccess: false, message: "Content type can't be empty.", payload: nil)
        }
        
        if(content.trimmingCharacters(in: .whitespacesAndNewlines).count < 6){
            return Response(isSuccess: false, message: "Content must have at least 6 character.", payload: nil)
        }
        
        let allowedContentTypes = ["Food", "Tech", "Music", "Travel", "Gaming"]
        if !allowedContentTypes.contains(contentType){
            return Response(isSuccess: false, message: "Content type must be 'Food', 'Tech', 'Music', 'Travel', or 'Gaming'.", payload: nil)
        }
        
        let cleanedContent = content.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        
        let post = Post(context: context)
        post.content = cleanedContent
        post.contentType = contentType
        post.uploadedAt = uploadedAt
        post.user = user
        
        user.addToPosts(post)
        
        do {
            try context.save()
            return Response(isSuccess: true, message: "Successfully create post.", payload: post)
        } catch {
            return Response(isSuccess: false, message: "Failed to create post.", payload: nil)
        }
    }
    
    func getPosts() -> Response {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        do {
            let posts = try context.fetch(fetchRequest)
            return Response(isSuccess: true, message: "Successfully fetched posts.", payload: posts)
        } catch {
            return Response(isSuccess: false, message: "Failed to fetch posts.", payload: nil)
        }
    }
    
    func deletePost(post: Post) -> Response {
        context.delete(post)
        
        do {
            try context.save()
            return Response(isSuccess: true, message: "Successfully deleted post.", payload: nil)
        } catch {
            return Response(isSuccess: false, message: "Failed to delete post.", payload: nil)
        }
    }
    
    func updatePost(post: Post, newContent: String, newContentType: String) -> Response {
        if(newContent.isEmpty){
            return Response(isSuccess: false, message: "Content can't be empty.", payload: nil)
        }
        
        if(newContentType.isEmpty){
            return Response(isSuccess: false, message: "Content type can't be empty.", payload: nil)
        }
        
        if(newContent.trimmingCharacters(in: .whitespacesAndNewlines).count < 6){
            return Response(isSuccess: false, message: "Content must have at least 6 characters.", payload: nil)
        }
        
        let allowedContentTypes = ["Food", "Tech", "Music", "Travel", "Gaming"]
        if !allowedContentTypes.contains(newContentType){
            return Response(isSuccess: false, message: "Content type must be 'Food', 'Tech', 'Music', 'Travel', or 'Gaming'.", payload: nil)
        }
        
        let cleanedContent = newContent.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        
        post.content = cleanedContent
        post.contentType = newContentType
        
        do {
            try context.save()
            return Response(isSuccess: true, message: "Successfully updated post.", payload: post)
        } catch {
            return Response(isSuccess: false, message: "Failed to update post.", payload: nil)
        }
    }
}
