//
//  PostListTableViewController.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 1/27/21.
//  Copyright © 2021 Cameron Stuart. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    var posts: [Post] = []
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostController.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = self.posts[indexPath.row]
        cell.post = post     
        
        return cell
    }
    
    //  MARK: Helper Functions
    
}
