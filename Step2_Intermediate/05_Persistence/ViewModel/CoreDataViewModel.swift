//
//  CoreDataViewModel.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/25/25.
//

import Foundation
import Combine

final class CoreDataViewModel: ObservableObject {
    @Published var items: [FavoriteArticle] = []
    private let context = CoreDataStack.shared.container.viewContext

    func fetch() {
        let request = FavoriteArticle.fetchRequest()
        items = (try? context.fetch(request)) ?? []
    }

    func add(title: String) {
        let new = FavoriteArticle(context: context)
        new.id = UUID()
        new.title = title
        try? context.save()
        fetch()
    }

    func delete(_ item: FavoriteArticle) {
        context.delete(item)
        try? context.save()
        fetch()
    }
}
