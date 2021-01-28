//
//  Post.swift
//  Master-Reddit
//
//  Created by Benjamin Tincher on 1/27/21.
//  Copyright © 2021 Cameron Stuart. All rights reserved.
//

import Foundation

struct TopLevelObject: Codable {
    let data: SecondLevelObject
}

struct SecondLevelObject: Codable {
    let children: [Post]
}

struct Post: Codable {
    let data: PostData
}

struct PostData: Codable {
    let title: String
    let ups: Int
    let thumbnail: URL
}
