//
//  PostController.swift
//  Master-Reddit
//
//  Created by Cameron Stuart on 4/28/20.
//  Copyright © 2020 Cameron Stuart. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PostController {
    
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        
        let baseURL = URL(string: "https://www.reddit.com/r/funny.json")
        
        guard let finalURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(PostTopLevelObject.self, from: data)
                let secondLevelDict = topLevelDictionary.data
                let thirdLevelArray = secondLevelDict.children
                
                var arrayOfPosts: [Post] = []
                
                for dict in thirdLevelArray {
                    let post = dict.data
                    arrayOfPosts.append(post)
                }
                return completion(.success(arrayOfPosts))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchThumbnail(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        
        guard let thumbnailURL = URL(string: post.thumbnail) else { return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: thumbnailURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            return completion(.success(thumbnail))
            
        }.resume()
    }
}
