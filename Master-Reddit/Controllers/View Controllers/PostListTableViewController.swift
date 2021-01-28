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
    var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostController.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
        
        for post in posts  {
            PostController.fetchThumbnail(post: post) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.images.append(image)
                    case .failure(let error):
                        self.presentErrorToUser(localizedError: error)
                    }
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

        let post = posts[indexPath.row]
        let thumbnail = images[indexPath.row]
        cell.thumbnail = thumbnail
        cell.post = post

        return cell
    }
}
