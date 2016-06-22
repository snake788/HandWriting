//
//  AlertHelper.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 21/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
    class func WSError(error: NSError?) -> UIAlertController {
        let alert = UIAlertController(title: "Oops", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(ok)
        
        return alert
    }
    
    class func genericAlert(text: String) -> UIAlertController {
        let alert = UIAlertController(title: "HandWritings", message: text, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        alert.addAction(ok)
        
        return alert
    }
}
