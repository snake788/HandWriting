//
//  HandWriting.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import Foundation

class HandWriting: NSObject {
    var id: String?
    var title: String?
    var dateCreated: NSDate?
    var dateModified: NSDate?
    var ratingNeatness: Int?
    var ratingCursivity: Int?
    var ratingEmbellishment: Int?
    var ratingCharacterWidth: Int?
    
    override init() {
        super.init()
    }
    
    convenience init(dictionnary: NSDictionary) {
        self.init()

        self.id = dictionnary.objectForKey("id") as? String
        self.title = dictionnary.objectForKey("title") as? String
        self.dateCreated = dictionnary.objectForKey("date_created") as? NSDate
        self.dateModified = dictionnary.objectForKey("date_modified") as? NSDate
        self.ratingNeatness = dictionnary.objectForKey("rating_neatness") as? Int
        self.ratingCursivity = dictionnary.objectForKey("rating_cursivity") as? Int
        self.ratingEmbellishment = dictionnary.objectForKey("rating_embellishment") as? Int
        self.ratingCharacterWidth = dictionnary.objectForKey("rating_character_width") as? Int
    }
}
