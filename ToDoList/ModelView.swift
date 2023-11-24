//
//  ModelView.swift
//  ToDoList
//
//  Created by 髙津悠樹 on 2023/11/10.
//

import SwiftUI

struct ModalView: View {
    @Binding var newTodoTitle: String
    @Binding var showingModal: Bool
    var addNewTodo: () -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("新規タスクを入力", text: $newTodoTitle)
                Button("追加") {
                    addNewTodo()
                }
            }
            .navigationBarItems(leading: Button("閉じる") {
                showingModal = false
            })
        }
    }
}
