//
//  ContentView.swift
//  BR Assignment
//
//  Created by Nasraddin Rustamov on 6/16/21.
//

import SwiftUI

struct ContentView: View {
    @State private var posts: [Post] = []
    var body: some View {
        NavigationView {
            List{
                ForEach(posts){ post in
                    NavigationLink(
                        destination: DetailView(post: post)){
                        HStack{
                            Image(systemName: "checkmark")
                                .foregroundColor(post.isRead ? .black : .white)
                            VStack{
                                Text(post.title)
                                    .font(.headline)
                                Text(post.content)
                                    .font(.subheadline)
                                    .lineLimit(1)
                            }
                            Spacer()
                        }
                        .simultaneousGesture(TapGesture().onEnded() {
                            if let matchingIndex =
                                self.posts.firstIndex(where: {$0.id == post.id}) {
                                self.posts[matchingIndex].isRead.toggle()
                            }
                        })
                    }
                }
            }
            .onAppear {
                Api().performRequest { (posts) in
                    self.posts = posts
                }
            }
            .navigationBarTitle(Text("BR Assignment"))
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

