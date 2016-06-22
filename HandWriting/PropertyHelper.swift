//
//  PropertyHelper.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import Foundation

class PropertyHelper: NSObject {
    static let handWritingAPIURL = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsKeys.HANDWRITING_API_URL) as! String
    
    static let getHandWritings = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsKeys.GET_HANDWRITINGS) as! String
    static let getRenderPNG = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsKeys.GET_RENDER_PNG) as! String
    
    static let allHandWritings = handWritingAPIURL + getHandWritings
    static let renderPNG = handWritingAPIURL + getRenderPNG
    
    static let handWritingAPIParamLimit = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_LIMIT) as! String
    static let handWritingAPIParamOffset = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_OFFSET) as! String
    static let handWritingAPIParamOrderDir = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_ORDER_DIR) as! String
    static let handWritingAPIParamOrderBy = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_ORDER_BY) as! String
    
    static let handWritingAPIParamHandWritingId = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_HANDWRITING_ID) as! String
    static let handWritingAPIParamText = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_TEXT) as! String
    static let handWritingAPIParamHandWritingSize = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_HANDWRITING_SIZE) as! String
    static let handWritingAPIParamHandWritingColor = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_HANDWRITING_COLOR) as! String
    static let handWritingAPIParamWidth = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_WIDTH) as! String
    static let handWritingAPIParamHeight = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_HEIGHT) as! String
    static let handWritingAPIParamLineSpacing = NSBundle.mainBundle().objectForInfoDictionaryKey(Constants.EndPointsParams.HANDWRITING_API_PARAM_LINE_SPACING) as! String
}
