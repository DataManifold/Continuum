//
//  PhotoSelectorViewController.swift
//  Continuum
//
//  Created by Shean Bjoralt on 10/7/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

protocol PhotoSelectorViewControllerDelegate: AnyObject {
    func photoSelectorViewControllerSelected(image: UIImage)
}

class PhotoSelectorViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    //MARK: - Properties
    
    weak var delegate: PhotoSelectorViewControllerDelegate?
    var post: Post?
    
    //MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        selectImageView.image = nil
        selectImageButton.setTitle("Select Image", for: .normal)
    }
    //MARK: - Action
    
    @IBAction func selectButtonTapped(_ sender: Any) {
        selectImageButton.setTitle("", for: .normal)
        presentImagePickerActionSheet()
    }
    
    //MARK: - Helper Methods
    
    
}

extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentImagePickerActionSheet() {

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        }

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: nil))

        }
        present(actionSheet, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImageView.image = photo
            selectImageButton.setTitle("", for: .normal)
        }
    }
}

