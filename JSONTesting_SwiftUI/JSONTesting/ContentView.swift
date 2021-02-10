//
//  ContentView.swift
//  JSONTesting
//
//  Created by Nasraddin Rustamov on 2/10/21.
//

import SwiftUI

struct ContentView: View {
    @State var posts: [Post] = []
    var body: some View {
        List(posts) { post in
            VStack{
            Text(post.title)
                .fontWeight(.bold)
                Text(post.body)
        }
        }
        .onAppear {
            Api().performRequest { (posts) in
                self.posts = posts
            }
        }
    }
}

struct Post : Codable, Identifiable {
    let id: Int
    var title: String
    var body: String
}

struct Api {
    let url = "https://jsonplaceholder.typicode.com/posts"
    
    func performRequest(competionHandler: @escaping ([Post]) -> Void) {
        
        guard let postsUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: postsUrl) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let posts = try? JSONDecoder().decode([Post].self,from: data)
                DispatchQueue.main.async {
                    competionHandler(posts!)
                }
        }
        }
        .resume()
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
