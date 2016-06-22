//
//  Enums.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct CoreData {
        static let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    struct Videos {
        static let HANDWRITING_WALKTHROUGH = "handWritingWalkthrough"
    }
    
    struct NotificationKeys {
        static let USER_HAS_ADDED_HANDWRITING_TO_CORE_DATA = "userHasAddedHandWritingToCoreData"
    }
    
    struct ApplicationKeys {
        static let FIRST_LAUNCH = "isFirstLaunch"
    }
    
    struct EndPointsKeys {
        static let HANDWRITING_API_URL = "handWritingAPIURL"
        static let GET_HANDWRITINGS = "getHandWritings"
        static let GET_RENDER_PNG = "getRenderPNG"
    }
    
    struct EndPointsParams {
        static let HANDWRITING_API_PARAM_LIMIT = "handWritingAPIParamLimit"
        static let HANDWRITING_API_PARAM_OFFSET = "handWritingAPIParamOffset"
        static let HANDWRITING_API_PARAM_ORDER_DIR = "handWritingAPIParamOrderDir"
        static let HANDWRITING_API_PARAM_ORDER_BY = "handWritingAPIParamOrderBy"
        static let HANDWRITING_API_PARAM_HANDWRITING_ID = "handWritingAPIParamHandWritingId"
        static let HANDWRITING_API_PARAM_TEXT = "handWritingAPIParamText"
        static let HANDWRITING_API_PARAM_HANDWRITING_SIZE = "handWritingAPIParamHandWritingSize"
        static let HANDWRITING_API_PARAM_HANDWRITING_COLOR = "handWritingAPIParamHandWritingColor"
        static let HANDWRITING_API_PARAM_WIDTH = "handWritingAPIParamWidth"
        static let HANDWRITING_API_PARAM_HEIGHT = "handWritingAPIParamHeight"
        static let HANDWRITING_API_PARAM_LINE_SPACING = "handWritingAPIParamLineSpacing"
    }
    
    struct CellKeys {
        static let TITLE_KEY = "title"
        static let CELL_TYPE_KEY = "cellType"
        static let CELL_IDENTIFIER_KEY = "cellIdentifier"
        static let CELL_HEIGHT_KEY = "cellHeight"
        static let OPTIONS_KEY = "options"
        static let DEFAULT_VALUE_KEY = "defaultValue"
        static let MAX_VALUE_KEY = "maxValue"
        static let VALUE_KEY = "value"
        static let DECODE_KEY = "decodeKey"
    }
}
