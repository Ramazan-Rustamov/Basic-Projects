//
//  ChecklistItem.swift
//  CheckList UIKit
//
//  Created by Nasraddin Rustamov on 2/2/21.
//

import Foundation

class ChecklistItem: Equatable {
    static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
        return lhs.text == rhs.text && lhs.checked == rhs.checked
    }
    
  var text = ""
  var checked = false
}
