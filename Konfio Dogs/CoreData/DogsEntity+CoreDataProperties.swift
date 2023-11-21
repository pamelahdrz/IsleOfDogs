//
//  DogsEntity+CoreDataProperties.swift
//  Konfio Dogs
//
//  Created by Pamela Hernández on 18/11/23.
//
//

import Foundation
import CoreData


extension DogsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DogsEntity> {
        return NSFetchRequest<DogsEntity>(entityName: "DogsEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var dogDescription: String?
    @NSManaged public var age: Int32
    @NSManaged public var image: String?

}

extension DogsEntity : Identifiable { }
