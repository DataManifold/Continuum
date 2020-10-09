//
//  PostListTableViewController.swift
//  Continuum
//
//  Created by Shean Bjoralt on 10/6/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var captionSearchBar: UISearchBar!
    
    //MARK: - Properties
    
    var resultsArray: [Post] = []
    
    var isSearching: Bool = false
    
    var dataSource: [Post] {
        if isSearching {
            return resultsArray
        } else {
            return PostController.shared.posts
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionSearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        resultsArray = PostController.shared.posts
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let post = dataSource[indexPath.row]
        cell.post = post

        return cell
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toPostDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? PostDetailTableViewController else { return }
            let postToSend = PostController.shared.posts[indexPath.row]
            destinationVC.post = postToSend
        }
    }
}

extension PostListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var filtertedPost: [Post] = []
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        for post in PostController.shared.posts {
            if post.matches(searchTerm: searchTerm) {
                filtertedPost.append(post)
            }
        }
        resultsArray = filtertedPost
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        resultsArray = PostController.shared.posts
        tableView.reloadData()
    }
}
