//
//  UIButton+HandWriting.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

extension UIButton {
    /**
     Add a corner radius to all button corners
     - parameter radius : Angle radius
     */
    func addCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
}
