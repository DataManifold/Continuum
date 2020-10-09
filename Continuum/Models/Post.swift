//
//  Post.swift
//  Continuum
//
//  Created by Shean Bjoralt on 10/6/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit
import CloudKit

class Post {
    
    
    
    var photoData: Data?
    var timestamp: Date
    var caption: String
    var comments: [Comment]
    var photo: UIImage? {
        get {
            guard let data = photoData else { return nil }
            return UIImage(data: data)
        } set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    
    init(timestamp: Date = Date(), caption: String, comments: [Comment] = [], photo: UIImage?) {
        self.timestamp = timestamp
        self.caption = caption
        self.comments = comments
        self.photo = photo
    }
}

extension Post: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        if caption.lowercased().contains(searchTerm.lowercased()) {
            return true
        } else {
            return false
        }
    }
}


