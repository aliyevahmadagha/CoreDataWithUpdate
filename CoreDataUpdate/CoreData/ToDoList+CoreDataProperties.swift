//
//  ToDoList+CoreDataProperties.swift
//  CoreDataUpdate
//
//  Created by Khalida Aliyeva on 02.11.24.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var title: String?

}

extension ToDoList : Identifiable {

}
