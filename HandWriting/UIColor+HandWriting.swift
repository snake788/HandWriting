//
//  UIColor+HandWriting.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

extension UIColor {
    static func HWYellow () -> UIColor {
        return UIColor(red: 248.0/255.0, green: 204.0/255.0, blue: 91.0/255.0, alpha: 1.0)
    }
    
    static func HWDarkGray () -> UIColor {
        return UIColor(red: 46.0/255.0, green: 46.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    }
    
    static func HWBlack1 () -> UIColor {
        return UIColor(red: 24.0/255.0, green: 25.0/255.0, blue: 31.0/255.0, alpha: 1.0)
    }
    
    static func HWBlack2 () -> UIColor {
        return UIColor(red: 29.0/255.0, green: 30.0/255.0, blue: 39.0/255.0, alpha: 1.0)
    }
    
    static func HWGray () -> UIColor {
        return UIColor(red: 62.0/255.0, green: 63.0/255.0, blue: 69.0/255.0, alpha: 1.0)
    }
    
    static func HWLightGray () -> UIColor {
        return UIColor(red: 161.0/255.0, green: 162.0/255.0, blue: 166.0/255.0, alpha: 1.0)
    }
    
    /**
     Convert a UIColor to RGB string
     - parameter self : The string
     - returns: RBG string like #000000 (Red, Green, Blue)
     */
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
