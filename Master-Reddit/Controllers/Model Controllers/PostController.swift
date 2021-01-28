//
//  PostController.swift
//  Master-Reddit
//
//  Created by Benjamin Tincher on 1/27/21.
//  Copyright © 2021 Cameron Stuart. All rights reserved.
//

import Foundation
import UIKit


class PostController {
    
    //  URLSession.shared.dataTask - get array of post objects to make as source of truth
    //  piece together URL
    //  dataTask URL
    //  decode JSON
    
    static let baseURL = URL(string: "https://www.reddit.com/r/funny.json")
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let finalURL = baseURL
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR 1 ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let secondLevelObject = topLevelObject.data
                let posts = secondLevelObject.children
                completion(.success(posts))
            } catch {
                print("======== ERROR 2 ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchThumbnail(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        
        let thumbnailURL = post.data.thumbnail
        
        URLSession.shared.dataTask(with: thumbnailURL) { (data, _, error) in
            if let error = error {
                print("======== ERROR 3 ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            if let thumbnailImage = UIImage(data: data) {
                completion(.success(thumbnailImage))
            } else {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
