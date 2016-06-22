//
//  OptionsSelectTableViewCell.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 21/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

class OptionsSelectTableViewCell: UITableViewCell {
    static let cellIdentifier = "OptionsSelectTableViewCell"
    static let cellHeight: CGFloat = 44.0

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(text: String) {
        self.textLabel?.text = text
    }
}
