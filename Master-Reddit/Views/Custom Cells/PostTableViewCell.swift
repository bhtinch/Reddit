//
//  PostTableViewCell.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/28/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postCellImageView: UIImageView!
    @IBOutlet weak var postCellTitleLabel: UILabel!
    @IBOutlet weak var postCellUPSLabel: UILabel!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
       
    func updateViews() {
        guard let post = post else { return }
        
        postCellTitleLabel.text = post.data.title
        postCellUPSLabel.text = String(post.data.ups)
        
        PostController.fetchThumbnail(post: post) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.postCellImageView.image = image
                case .failure(_):
                    guard let imageNotAvailable = UIImage(named: "imageNotAvailable") else { return }
                    self.postCellImageView.image = imageNotAvailable
                }
            }
        }
    }
    
}
