//
//  PostTableViewCell.swift
//  Continuum
//
//  Created by Shean Bjoralt on 10/6/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextLabel: UILabel!
    @IBOutlet weak var commentsTextLabel: UILabel!
    
    //MARK: - Properties
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Helper Methods
    
    func updateViews() {
        postImageView.image = post?.photo
        captionTextLabel.text = post?.caption
        commentsTextLabel.text = "Comments: \(post?.comments.count ?? 0)"
    }
    

}
