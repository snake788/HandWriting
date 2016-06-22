//
//  RenderOptions.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import Foundation

class RenderOptions: NSObject {
    var handWritingId: String?
    var text: String?
    var handWritingSize: Float?
    var handWritingColor: String?
    var width: Float?
    var height: Float?
    var lineSpacing: Float?
    
    override init() {
        super.init()
    }
    
    convenience init(dictionnary: NSDictionary, handWriting: HandWriting) {
        self.init()
        
        self.handWritingId = handWriting.id
        self.text = dictionnary.objectForKey("text") as? String
        self.handWritingSize = dictionnary.objectForKey("handwriting_size") as? Float
        self.handWritingColor = dictionnary.objectForKey("handwriting_color") as? String
        self.width = dictionnary.objectForKey("width") as? Float
        self.height = dictionnary.objectForKey("height") as? Float
        self.lineSpacing = dictionnary.objectForKey("line_spacing") as? Float
    }
}
