//
//  HandWritings+CoreDataProperties.swift
//  
//
//  Created by Aurélien WOLFERT on 21/06/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HandWritings {

    @NSManaged var renderPNG: NSData?
    @NSManaged var title: String?

}
