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
    
    lazy var thumbnail = UIImage()
    
    func updateViews() {
        guard let post = post else { return }
        
        postCellTitleLabel.text = post.data.title
        postCellUPSLabel.text = String(post.data.ups)
        postCellImageView.image = thumbnail
    }
    
}
