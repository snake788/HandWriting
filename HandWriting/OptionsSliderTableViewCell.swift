//
//  OptionsSliderTableViewCell.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

protocol OptionsSliderTableViewCellProtocol: class {
    func sliderValueDidChange(value: Float, indexPath: NSIndexPath)
}

class OptionsSliderTableViewCell: UITableViewCell {
    @IBOutlet weak var labelOption: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var labelMinValue: UILabel!
    @IBOutlet weak var labelMaxValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    weak var delegate: OptionsSliderTableViewCellProtocol?

    static let cellIdentifier = "OptionsSliderTableViewCell"
    static let cellHeight: CGFloat = 60.0
    var indexPathForThisCell: NSIndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(options: NSDictionary, indexPath: NSIndexPath) {
        self.indexPathForThisCell = indexPath
        self.labelMinValue.text = String(0)
        
        guard options.objectForKey(Constants.CellKeys.TITLE_KEY) != nil else { return }
        guard options.objectForKey(Constants.CellKeys.DEFAULT_VALUE_KEY) != nil else { return }
        guard options.objectForKey(Constants.CellKeys.MAX_VALUE_KEY) != nil else { return }
        
        self.labelOption.text = (options.objectForKey(Constants.CellKeys.TITLE_KEY) as? String)! + " (px)"
        self.labelMaxValue.text = String(options.objectForKey(Constants.CellKeys.MAX_VALUE_KEY) as! Int)
        
        self.slider.minimumValue = 0.0
        self.slider.maximumValue = options.objectForKey(Constants.CellKeys.MAX_VALUE_KEY) as! Float
        self.slider.value = options.objectForKey(Constants.CellKeys.DEFAULT_VALUE_KEY) as! Float
        self.labelValue.text = String(self.slider.value)
    }
    
    // MARK: - Slider action -
    
    @IBAction func sliderTouched(sender: UISlider) {
        self.delegate?.sliderValueDidChange(sender.value, indexPath: self.indexPathForThisCell)
        
        self.labelValue.text = String(format: "%.1f", sender.value)
    }
}
