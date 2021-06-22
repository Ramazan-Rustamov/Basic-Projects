//
//  Data.swift
//  BR Assignment
//
//  Created by Nasraddin Rustamov on 6/17/21.
//

import Foundation

struct Post : Codable, Identifiable {
    var id: Int
    var title: String
    var content: String
    var isRead: Bool = false

    enum CodingKeys: String, CodingKey {
    case id, title, content
}
}
