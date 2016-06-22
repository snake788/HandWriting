//
//  WSManager+RenderPNG.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 21/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import Foundation
import AFNetworking

extension WSManager {
    /**
     Get a render PNG from server and return it to the controller via a completion
     - parameter renderOptions: A RenderOptions objects that contains parameters request
     - returns: A render PNG data if success / an error in case of failure
     */
    static func getRenderPNG(renderOptions: RenderOptions!, completion: (renderPNG: NSData?, error: NSError?) -> Void) {
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "image/png") as Set<NSObject>
        
        let parameters = [PropertyHelper.handWritingAPIParamHandWritingId:renderOptions.handWritingId!,
                          PropertyHelper.handWritingAPIParamText:renderOptions.text!,
                          PropertyHelper.handWritingAPIParamHandWritingSize:String(renderOptions.handWritingSize!)+"px",
                          PropertyHelper.handWritingAPIParamHandWritingColor:renderOptions.handWritingColor!,
                          PropertyHelper.handWritingAPIParamWidth:String(renderOptions.width!)+"px",
                          PropertyHelper.handWritingAPIParamHeight:String(renderOptions.height!)+"px",
                          PropertyHelper.handWritingAPIParamLineSpacing:String(renderOptions.lineSpacing!)]
        
        manager.GET(RENDER_PNG_URL, parameters: parameters, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            //success
            
            completion(renderPNG: operation.responseData, error: nil)
        }) { (operation: AFHTTPRequestOperation!, error: NSError!) in
            //failure
            
            completion(renderPNG: nil, error: error)
        }
    }
}
