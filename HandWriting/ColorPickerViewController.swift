//
//  ColorPickerViewController.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 21/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

protocol ColorPickerViewControllerProtocol: class {
    func colorDidPick(color: String, indexPath: NSIndexPath)
}

class ColorPickerViewController: UIViewController {
    @IBOutlet var barButtonItemDone: UIBarButtonItem!
    
    weak var delegate: ColorPickerViewControllerProtocol?
    
    var colorPicker: SwiftHSVColorPicker!
    var indexPathSelected: NSIndexPath!
    
    // MARK: - Controller lifecyle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
        self.setupColorPicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI -
    
    private func updateUI() {
        self.navigationItem.rightBarButtonItem = self.barButtonItemDone
        self.navigationItem.title = NSLocalizedString("COLOR_PICKER_TITLE", comment: "")
    }
    
    /**
     Setup a SwiftHSVColorPicker and display it in view
     */
    private func setupColorPicker() {
        self.colorPicker = SwiftHSVColorPicker(frame: CGRectMake(0.0, 0.0, self.view.bounds.width, 300.0))
        colorPicker.setViewColor(UIColor.redColor())
        self.view.addSubview(colorPicker)
    }
    
    // MARK: - Bar button item action -
    
    @IBAction func barButtonItemDoneTouched(sender: UIBarButtonItem) {
        self.delegate?.colorDidPick(self.colorPicker.color.toHexString(), indexPath: self.indexPathSelected)
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
