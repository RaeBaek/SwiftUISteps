//
//  TodoListView.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/19/25.
//

/*
 - List는 LazyVStack 기반 -> 아이템이 많아도 성능이 좋음
 - NavigationStack은 path 기반으로 push/pop 제어 가능
 - UIKit처럼 Cell 재사용을 신경쓸 필요가 없음
 */

import SwiftUI

struct Todo: Identifiable {
    let id = UUID()
    let title: String
}

struct TodoListView: View {
    @State private var todos: [Todo] = [
        Todo(title: "SwiftUI 공부"),
        Todo(title: "Combine 예제 만들기")
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    Text(todo.title)
                }
                .onDelete { indexSet in
                    todos.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("할 일 목록")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        todos.append(Todo(title: "새로운 할 일"))
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    TodoListView()
}
