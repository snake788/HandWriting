//
//  OptionsTextViewTableViewCell.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

protocol OptionsTextViewTableViewCellProtocol: class {
    func textDidChange(text: String, indexPath: NSIndexPath)
}

let maxTextViewLength = 9000

class OptionsTextViewTableViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: OptionsTextViewTableViewCellProtocol?
    
    static let cellIdentifier = "OptionsTextViewTableViewCell"
    static let cellHeight: CGFloat = 180.0
    var indexPathForThisCell: NSIndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textView.delegate = self
    }
    
    func updateCell(options: NSDictionary, indexPath: NSIndexPath) {
        self.indexPathForThisCell = indexPath
        
        guard options.objectForKey(Constants.CellKeys.TITLE_KEY) != nil else { return }
        
        self.textView.text = options.objectForKey(Constants.CellKeys.TITLE_KEY) as? String
    }
}

extension OptionsTextViewTableViewCell: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        self.delegate?.textDidChange(textView.text, indexPath: self.indexPathForThisCell)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let maxTextLength = textView.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) + text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) - range.length
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return maxTextLength > maxTextViewLength ? false : true
    }
}
