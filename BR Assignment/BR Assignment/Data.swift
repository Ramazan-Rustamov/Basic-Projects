//
//  Data.swift
//  BR Assignment
//
//  Created by Nasraddin Rustamov on 6/17/21.
//

import Foundation
import Combine

struct Post : Codable, Identifiable {
    var id: Int
    var title: String
    var content: String
    var isRead: Bool = false

    enum CodingKeys: String, CodingKey {
    case id, title, content
}
}

class UserSettings: ObservableObject{
    @Published var checked: Bool {
        didSet {
            UserDefaults.standard.set(checked, forKey: "checked")
        }
    }
    init() {
        self.checked = (UserDefaults.standard.object(forKey: "checked") != nil)
    }
}
