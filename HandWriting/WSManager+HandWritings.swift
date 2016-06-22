//
//  WSManager+HandWritings.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import Foundation
import AFNetworking

enum ORDER_DIRECTION: String {
    case ASC = "asc"
    case DESC = "desc"
}

let handWritingsLimit = 50
let handWritingsOrderBy = "title"

extension WSManager {
    /**
     Fetch all handwtrings from server and return them to the controller via a completion
     - returns: An array of Handwritings objects if success / an error in case of failure
     */
    static func fetchAllHandWritings(completion: (allHandWritings: Array<HandWriting>?, error: NSError?) -> Void) {
        let parameters = [PropertyHelper.handWritingAPIParamLimit:handWritingsLimit,
                          PropertyHelper.handWritingAPIParamOffset:0,
                          PropertyHelper.handWritingAPIParamOrderDir:ORDER_DIRECTION.ASC.rawValue,
                          PropertyHelper.handWritingAPIParamOrderBy:handWritingsOrderBy]
        
        manager.GET(ALL_HANDWRITINGS_URL, parameters: parameters, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            //success
            
            completion(allHandWritings: parseAllHandWritingsResponse(responseObject as! NSArray), error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) in
                //failure

                completion(allHandWritings: nil, error: error)
        }
    }
    
    /**
     Decode all JSON array received from server to real HandWritings objects
     - parameter allHandWritings: An array of JSON
     - returns: An array of Handwritings objects
     */
    private static func parseAllHandWritingsResponse(allHandWritings: NSArray) -> Array<HandWriting> {
        var handWritings = Array<HandWriting>()
        
        for dictionnary in allHandWritings {
            let handWriting = HandWriting(dictionnary: dictionnary as! NSDictionary)
        
            handWritings.append(handWriting)
        }
        
        return handWritings
    }
}
