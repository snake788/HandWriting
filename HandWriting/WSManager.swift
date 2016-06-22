//
//  WSManager.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import Foundation
import AFNetworking

class WSManager: NSObject {
    static let manager = AFHTTPRequestOperationManager()
    
    static let ALL_HANDWRITINGS_URL = PropertyHelper.allHandWritings
    static let RENDER_PNG_URL = PropertyHelper.renderPNG
}
