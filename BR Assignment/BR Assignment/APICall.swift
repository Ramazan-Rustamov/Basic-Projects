//
//  APICall.swift
//  BR Assignment
//
//  Created by Nasraddin Rustamov on 6/17/21.
//

import Foundation

struct Api {
    let url = "https://assignment-ramazan.free.beeceptor.com"
    
    func performRequest(completionHandler: @escaping ([Post]) -> Void) {
        
        guard let postsUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: postsUrl) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let posts = try? JSONDecoder().decode([Post].self,from: data)
                DispatchQueue.main.async {
                    completionHandler(posts!)
                }
            }
        }
        .resume()
    }
}
