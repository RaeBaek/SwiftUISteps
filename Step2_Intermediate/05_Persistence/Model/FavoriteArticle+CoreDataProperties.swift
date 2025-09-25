//
//  FavoriteArticle+CoreDataProperties.swift
//  SwiftUISteps
//
//  Created by 백래훈 on 9/25/25.
//
//

import Foundation
import CoreData


extension FavoriteArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteArticle> {
        return NSFetchRequest<FavoriteArticle>(entityName: "FavoriteArticle")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension FavoriteArticle : Identifiable {

}
