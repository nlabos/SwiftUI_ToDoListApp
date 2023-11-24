//
//  TodoItem.swift
//  ToDoList
//
//  Created by 髙津悠樹 on 2023/11/18.
//

import Foundation
import SwiftUI

// Todo項目を表す構造体
struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
