//
//  MealView.swift
//  ToDoList
//
//  Created by 髙津悠樹 on 2023/11/10.
//

import SwiftUI

struct MealView: View {
    var mealName: String
    var rating: Int

    var body: some View {
        HStack {
            Image(mealName)
                .resizable()
                .frame(width: 50, height: 50)
            Text(mealName)
            Spacer()
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .foregroundColor(index <= rating ? .yellow : .gray)
                }
            }
        }
    }
}

struct MealsListView: View {
    var body: some View {
        NavigationView {
            List {
                MealView(mealName: "Hamburger", rating: 4)
                MealView(mealName: "Sushi Bento", rating: 5)
                MealView(mealName: "Grilled Beef", rating: 3)
                // 他の食事の項目を追加...
            }
            .navigationBarTitle("Your Meals")
            .navigationBarItems(trailing: Button(action: {
                // 追加ボタンのアクションをここに書く
            }) {
                Image(systemName: "plus")
            })
        }
    }
}


#Preview {
    MealsListView()
}
