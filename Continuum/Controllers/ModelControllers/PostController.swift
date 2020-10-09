//
//  PostController.swift
//  Continuum
//
//  Created by Shean Bjoralt on 10/6/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit
import CloudKit

class PostController {
    
    //MARK: - Properties
    
    static let shared = PostController()
    
    var posts: [Post] = []
    
    //MARK: - CRUD Functions
    
    func addComment(text: String, post: Post, completion: @escaping (Result<Comment, PostError>) -> Void ) {
        
        let newComment = Comment(text: text, post: post)
        post.comments.append(newComment)
    }
    
    func createPostWith(photo: UIImage, caption: String, completion: @escaping (Result<Post?, PostError>) -> Void) {
        
        let newPost = Post(caption: caption, photo: photo)
        posts.append(newPost)
    }
    
}
