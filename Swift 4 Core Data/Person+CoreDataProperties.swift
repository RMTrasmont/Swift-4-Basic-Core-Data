//
//  Person+CoreDataProperties.swift
//  Swift 4 Core Data
//
//  Created by Rafael M. Trasmontero on 1/3/18.
//  Copyright © 2018 KLTuts. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: Int16

}
