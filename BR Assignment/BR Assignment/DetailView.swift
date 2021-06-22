//
//  DetailView.swift
//  BR Assignment
//
//  Created by Nasraddin Rustamov on 6/17/21.
//

import SwiftUI

struct DetailView: View {
    var post: Post
    var body: some View {
        VStack{
            Text(post.title)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
            Text(post.content)
                .font(.subheadline)
            Spacer()
        }
    }
}
