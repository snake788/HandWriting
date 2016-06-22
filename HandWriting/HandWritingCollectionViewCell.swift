//
//  HandWritingCollectionViewCell.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 21/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

class HandWritingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    static let cellIdentifier = "HandWritingCollectionCell"
    static let cellSize = CGSizeMake(250.0, 250.0)
    
    func updateCell(title: String, imageData: NSData?) {
        self.title.text = title
        
        if let finalImageData = imageData {
            imageView.image = UIImage(data: finalImageData)
        } else {
            imageView.image = nil
        }
    }
}
