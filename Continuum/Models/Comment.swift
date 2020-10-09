//
//  Comment.swift
//  Continuum
//
//  Created by Shean Bjoralt on 10/6/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit
import CloudKit

class Comment {
    var text: String
    var timestamp: Date
    weak var post: Post?
    
    init(text: String, timestamp: Date = Date(), post: Post?) {
        self.text = text
        self.timestamp = timestamp
        self.post = post
    }
}
