//
//  ContentView.swift
//  ToDoList
//
//  Created by 髙津悠樹 on 2023/11/10.
//

import SwiftUI

struct ContentView: View {
    @State private var todos: [TodoItem] {
        didSet {
            saveTodos()
        }
    }
    @State private var newTodoTitle = ""
    @State private var showingModal = false
    
    // UserDefaultsからの読み込みを含むイニシャライザ
    init() {
        if let savedTodos = UserDefaults.standard.data(forKey: "Todos") {
            if let decodedTodos = try? JSONDecoder().decode([TodoItem].self, from: savedTodos) {
                _todos = State(initialValue: decodedTodos)
                return
            }
        }
        _todos = State(initialValue: [])
    }
    
    var body: some View {
        NavigationView {
            List {
                // 未完了のタスク用のセクション
                // 未完了のタスク用のセクション
                Section(header: Text("未完了")) {
                    ForEach($todos) { $todo in
                        if !todo.isCompleted {
                            TodoRow(todo: $todo)
                        }
                    }
                    .onDelete(perform: delete)
                }
                
                // 完了したタスク用のセクション
                Section(header: Text("完了")) {
                    ForEach($todos) { $todo in
                        if todo.isCompleted {
                            TodoRow(todo: $todo)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationBarTitle("My TodoList", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showingModal = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingModal) {
                ModalView(newTodoTitle: $newTodoTitle, showingModal: $showingModal, addNewTodo: addNewTodo)
            }
            .onDisappear {
                saveTodos()
            }
        }
    }
    
    func addNewTodo() {
        if !newTodoTitle.isEmpty {
            let newTodo = TodoItem(title: newTodoTitle, isCompleted: false)
            todos.append(newTodo)
            newTodoTitle = ""
            showingModal = false
            saveTodos()
        }
    }
    
    func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
        saveTodos()
    }
    
    func saveTodos() {
        if let encoded = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(encoded, forKey: "Todos")
        }
    }
    
}

struct TodoRow: View {
    @Binding var todo: TodoItem
    
    var body: some View {
        HStack {
            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(todo.isCompleted ? .green : .gray)
                .onTapGesture {
                    todo.isCompleted.toggle()
                    // タップしたときにUserDefaultsに保存
                }
            Text(todo.title)
                .strikethrough(todo.isCompleted, color: .black)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
