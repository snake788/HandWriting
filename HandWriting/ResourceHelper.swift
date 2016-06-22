//
//  ResourceHelper.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import Foundation
import AVFoundation

class ResourceHelper {
    /**
     Return full URL of a resource presents in the main bundle
     - parameter fileName: Filename to explore
     - parameter fileType: File extension
     - returns: Full URL resource
     */
    class func getDocumentURLForFile(fileName: String, fileType: VideoFileTypes) -> NSURL {
        let fileString = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType.rawValue)
        
        return NSURL(fileURLWithPath: fileString!)
    }
    
    /**
     Return item URL to play it in video player
     - parameter fileName: Filename to read
     - returns: Item from URL
     */
    class func getPlayerItemForFile(fileName: String) -> AVPlayerItem {
        let videoPath = getDocumentURLForFile(fileName, fileType: VideoFileTypes.M4V)
        
        return AVPlayerItem(URL: videoPath)
    }
}
