//
//  FontSelectionTableViewCell.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

class FontSelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelNeatness: UILabel!
    @IBOutlet weak var labelCursivity: UILabel!
    @IBOutlet weak var labelEmbellishment: UILabel!
    @IBOutlet weak var labelCharacterWidth: UILabel!
    @IBOutlet weak var labelRatingNeatness: UILabel!
    @IBOutlet weak var labelRatingCursivity: UILabel!
    @IBOutlet weak var labelRatingEmbellishment: UILabel!
    @IBOutlet weak var labelRatingCharacterWidth: UILabel!
    
    static let cellIdentifier = "FontSelectionTableViewCell"
    static let cellHeight: CGFloat = 95.0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(handWriting: HandWriting) {
        self.labelNeatness.text = NSLocalizedString("CELL_FONT_SELECTION_NEATNESS", comment: "")
        self.labelCursivity.text = NSLocalizedString("CELL_FONT_SELECTION_CURSIVITY", comment: "")
        self.labelEmbellishment.text = NSLocalizedString("CELL_FONT_SELECTION_EMBELLISHMENT", comment: "")
        self.labelCharacterWidth.text = NSLocalizedString("CELL_FONT_SELECTION_CHARACTER_WIDTH", comment: "")
        
        guard handWriting.title != nil else { return }
        guard handWriting.ratingNeatness != nil else { return }
        guard handWriting.ratingCursivity != nil else { return }
        guard handWriting.ratingEmbellishment != nil else { return }
        guard handWriting.ratingCharacterWidth != nil else { return }
        
        self.labelTitle.text = handWriting.title
        self.labelRatingNeatness.text = String(handWriting.ratingCharacterWidth!)
        self.labelRatingCursivity.text = String(handWriting.ratingCursivity!)
        self.labelRatingEmbellishment.text = String(handWriting.ratingEmbellishment!)
        self.labelRatingCharacterWidth.text = String(handWriting.ratingCharacterWidth!)
        
    }
}
