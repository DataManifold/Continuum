//
//  PostDetailTableViewController.swift
//  Continuum
//
//  Created by Shean Bjoralt on 10/6/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    //MARK: - Outlet
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: - Properties
    
    var post: Post? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Helper Methods
    
    func updateViews() {
        photoImageView.image = post?.photo
        tableView.reloadData()
    }
    
    func commentAlertController() {
        let alertController = UIAlertController(title: "Add Comment", message: "Please enter comment here.", preferredStyle: .alert)
        alertController.addTextField { (textField) in
          textField.placeholder = "Your commment"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let commentAction = UIAlertAction(title: "Ok", style: .default) { (_) in
          guard let commentText = alertController.textFields?.first?.text,
            !commentText.isEmpty,
            let post = self.post else { return }
            PostController.shared.addComment(text: commentText, post: post) { (comment) in
                //check if code is needed
            }
          self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(commentAction)
        self.present(alertController, animated: true, completion: nil)
      }
    
    //MARK: - Actions
    
    @IBAction func commentButtonTapped(_ sender: Any) {
        commentAlertController()
    }
    @IBAction func shareButtonTapped(_ sender: Any) {
    }
    @IBAction func followButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post?.comments.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)

        let comment = post?.comments[indexPath.row]
        cell.textLabel?.text = comment?.text
        cell.detailTextLabel?.text = comment?.timestamp.formatDate()

        return cell
    }
}
