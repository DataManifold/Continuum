//
//  AddPostTableViewController.swift
//  Continuum
//
//  Created by Shean Bjoralt on 10/6/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class AddPostTableViewController: UITableViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var captionTextField: UITextField!
    
    //MARK: - Properties
    
    var post: Post?
    
    var selectImageView: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captionTextField.text = ""
    }

    //MARK: - Actions
    
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        guard let photo = selectImageView, let caption = captionTextField.text else { return }
        PostController.shared.createPostWith(photo: photo, caption: caption) { (result) in
            switch result {
            case .success(let post):
                guard let post = post else { return }
                PostController.shared.posts.append(post)
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        self.tabBarController?.selectedIndex = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelector" {
            if let destinationVC = segue.destination as? PhotoSelectorViewController {
                destinationVC.delegate = self
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
}

extension AddPostTableViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        selectImageView = image
    }
}
