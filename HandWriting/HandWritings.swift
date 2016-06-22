//
//  HandWritings.swift
//  
//
//  Created by Aurélien WOLFERT on 21/06/2016.
//
//

import Foundation
import CoreData

protocol HandWritingsProtocol: class {
    func coreDataHasAddHandWriting()
}

weak var handWritingsDelegate:HandWritingsProtocol?

private let entityName = "HandWritings"

@objc(HandWritings)
class HandWritings: NSManagedObject {
    /**
     Add a render PNG to the persistant store
     - parameter renderPNG: The render PNG data
     - parameter title: The title that will be display in handwritings collection (renderd text + creation date)
     */
    class func addRenderPNG(renderPNG: NSData, title: String) {
        let newRenderPNG = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: Constants.CoreData.managedObjectContext) as! HandWritings
        
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM hh:mm:ss"
        let dateString = dateFormatter.stringFromDate(date)
        
        newRenderPNG.renderPNG = renderPNG
        newRenderPNG.title = "\(dateString) - \(title)"
        
        do {
            try Constants.CoreData.managedObjectContext.save()
            
            handWritingsDelegate?.coreDataHasAddHandWriting()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    /**
     Get all handwritings persist in the persistant store
     - returns: A fetched result controller that contains all fetched objects (HandWritings objects in this case)
     */
    class func getHandWritings() -> NSFetchedResultsController {
        let request = NSFetchRequest(entityName: entityName)
        let sectionNameKeyPath = "title"
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        let resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Constants.CoreData.managedObjectContext, sectionNameKeyPath: sectionNameKeyPath, cacheName: nil)
        
        return resultsController
    }
}
