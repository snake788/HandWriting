//
//  OptionsTableViewController.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit

let maxValue: Float = 1000.0
let handWritingSizeDefaultValue:Float = 20.0
let handWritingSizeMaxValue:Float = 200.0
let handWritingColorDefaultValue = "#000000"
let widthDefaultValue: Float = 504.0
let heightDefaultValue: Float = 360.0
let lineSpacingDefaultValue: Float = 1.5
let lineSpacingMaxValue: Float = 5.0
let textViewDefaultText = "Texte"

class OptionsTableViewController: UITableViewController {
    @IBOutlet var barButtonItemNext: UIBarButtonItem!
    
    var handWritingSelected: HandWriting!
    var tableViewCellsDataSource = [NSMutableDictionary]()
    var isFirstLayout: Bool = true
    var enteredText: String!
    
    // MARK: - Controller lifecyle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
        self.registerTableViewCells()
        self.buildTableViewCells()
        self.enteredText = textViewDefaultText
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isFirstLayout {
            self.isFirstLayout = false
            
            NSNotificationCenter.defaultCenter().addObserverForName(Constants.NotificationKeys.USER_HAS_ADDED_HANDWRITING_TO_CORE_DATA, object: nil, queue: nil, usingBlock: { (notification) in
                self.presentViewController(AlertHelper.genericAlert(NSLocalizedString("CORE_DATA_HAS_ADD_HANDWRITING", comment: "")), animated: true) {}
            })
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: Constants.NotificationKeys.USER_HAS_ADDED_HANDWRITING_TO_CORE_DATA, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI -
    
    private func updateUI() {
        self.navigationItem.rightBarButtonItem = self.barButtonItemNext
        self.navigationItem.title = NSLocalizedString("OPTIONS_TVC_TITLE", comment: "")
    }
    
    private func registerTableViewCells() {
        self.tableView.registerNib(UINib(nibName: OptionsSliderTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: OptionsSliderTableViewCell.cellIdentifier)
        self.tableView.registerNib(UINib(nibName: OptionsTextViewTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: OptionsTextViewTableViewCell.cellIdentifier)
        self.tableView.registerNib(UINib(nibName: OptionsSelectTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: OptionsSelectTableViewCell.cellIdentifier)
    }
    
    // MARK: - Bar buttons items actions -
    
    @IBAction func barButtonItemNextTouched(sender: UIBarButtonItem) {
        if self.enteredText.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            self.performSegueWithIdentifier("renderSegue", sender: self)
        } else {
            self.presentViewController(AlertHelper.genericAlert(NSLocalizedString("TEXT_VIEW_MUST_HAVE_LENGTH", comment: "")), animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation -
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "renderSegue" {
            let renderVC = segue.destinationViewController as! RenderViewController
            renderVC.renderOptions = self.convertDataSourceToRenderOptions()
        } else if segue.identifier == "colorPickerSegue" {
            let colorPickerVC = segue.destinationViewController as! ColorPickerViewController
            colorPickerVC.indexPathSelected = self.tableView.indexPathForSelectedRow
            colorPickerVC.delegate = self
        }
    }
    
    // MARK: - Data source -
    
    private func buildTableViewCells() {
        self.buildOptionsTextViewCell(textViewDefaultText, decode: "text")
        self.buildOptionsSelectCell(handWritingColorDefaultValue, decode: "handwriting_color")
        self.buildOptionsSliderCell(NSLocalizedString("CELL_OPTIONS_HANDWRITING_SIZE", comment: ""), maxValue: handWritingSizeMaxValue, defaultValue: handWritingSizeDefaultValue, decode: "handwriting_size")
        self.buildOptionsSliderCell(NSLocalizedString("CELL_OPTIONS_WIDTH", comment: ""), maxValue: maxValue, defaultValue: widthDefaultValue, decode: "width")
        self.buildOptionsSliderCell(NSLocalizedString("CELL_OPTIONS_HEIGHT", comment: ""), maxValue: maxValue, defaultValue: heightDefaultValue, decode: "height")
        self.buildOptionsSliderCell(NSLocalizedString("CELL_OPTIONS_LINE_SPACING", comment: ""), maxValue: lineSpacingMaxValue, defaultValue: lineSpacingDefaultValue, decode: "line_spacing")
    }
    
    /**
     Append a mutable dictionary to an array of mutable dictionaries that containing set of keys/values intended for build table view text view cells and retrieve user data
     - parameter title: The text to display by default in textView
     - parameter decode: The string allowing to decode data into the class object
     */
    private func buildOptionsTextViewCell(title: String, decode: String) {
        let options: NSMutableDictionary = [Constants.CellKeys.CELL_TYPE_KEY:OptionsCells.TEXT.rawValue,
                                            Constants.CellKeys.CELL_IDENTIFIER_KEY:OptionsTextViewTableViewCell.cellIdentifier,
                                            Constants.CellKeys.CELL_HEIGHT_KEY:OptionsTextViewTableViewCell.cellHeight,
                                            Constants.CellKeys.OPTIONS_KEY:[Constants.CellKeys.TITLE_KEY:title],
                                            Constants.CellKeys.VALUE_KEY:title,
                                            Constants.CellKeys.DECODE_KEY:decode]
        
        self.tableViewCellsDataSource.append(options)
    }
    
    /**
     Append a mutable dictionary to an array of mutable dictionaries that containing set of keys/values intended for build table view selection cells and retrieve user data
     - parameter defaultValue: The default value that will be apply if the user not select this cell
     - parameter decode: The string allowing to decode data into the class object
     */
    private func buildOptionsSelectCell(defaultValue: String, decode: String) {
        let options: NSMutableDictionary = [Constants.CellKeys.CELL_TYPE_KEY:OptionsCells.SELECT.rawValue,
                                            Constants.CellKeys.CELL_IDENTIFIER_KEY:OptionsSelectTableViewCell.cellIdentifier,
                                            Constants.CellKeys.CELL_HEIGHT_KEY:OptionsSelectTableViewCell.cellHeight,
                                            Constants.CellKeys.VALUE_KEY:defaultValue,
                                            Constants.CellKeys.DECODE_KEY:decode]
        
        self.tableViewCellsDataSource.append(options)
    }
    
    /**
     Append a mutable dictionary to an array of mutable dictionaries that containing set of keys/values intended for build table view slider cells and retrieve user data
     - parameter title: The text to display by default to idenfity option
     - parameter maxValue: The max value the the slider can be have
     - parameter defaultValue: The default value that will be apply to the slider
     - parameter decode: The string allowing to decode data into the class object
     */
    private func buildOptionsSliderCell(title: String, maxValue: Float, defaultValue: Float, decode: String) {
        let options: NSMutableDictionary = [Constants.CellKeys.CELL_TYPE_KEY:OptionsCells.SLIDER.rawValue,
                                            Constants.CellKeys.CELL_IDENTIFIER_KEY:OptionsSliderTableViewCell.cellIdentifier,
                                            Constants.CellKeys.CELL_HEIGHT_KEY:OptionsSliderTableViewCell.cellHeight,
                                            Constants.CellKeys.OPTIONS_KEY:[Constants.CellKeys.TITLE_KEY:title,
                                                Constants.CellKeys.MAX_VALUE_KEY:maxValue,
                                                Constants.CellKeys.DEFAULT_VALUE_KEY:defaultValue],
                                            Constants.CellKeys.VALUE_KEY:defaultValue,
                                            Constants.CellKeys.DECODE_KEY:decode]
        
        self.tableViewCellsDataSource.append(options)
    }
    
    /**
     Set a new value in the data source array for the VALUE_KEY
     - parameter indexPath: The indexPath of the selectedCell to retrieve index
     - parameter value: The new value that will be set
     */
    private func updateTableViewCellsDataSource(indexPath: NSIndexPath, value: AnyObject) {
        let options = self.tableViewCellsDataSource[indexPath.row]
        
        options.setValue(value, forKey: Constants.CellKeys.VALUE_KEY)
    }
    
    /**
     Extract only required fields in order to pass them in request paramter and build a RenderOptions object
     - returns: A RenderOptions object
     */
    private func convertDataSourceToRenderOptions() -> RenderOptions {
        let renderDict = NSMutableDictionary()
        
        for options in self.tableViewCellsDataSource {
            let key = options.valueForKey(Constants.CellKeys.DECODE_KEY) as! String
            let value = options.valueForKey(Constants.CellKeys.VALUE_KEY)
            
            renderDict.setValue(value!, forKey: key)
        }
        
        return RenderOptions(dictionnary: renderDict, handWriting: self.handWritingSelected)
    }

    // MARK: - Table view stack -

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("OPTIONS_TVC_TABLE_VIEW_HEADER", comment: "") + self.handWritingSelected.title!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewCellsDataSource.count
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let optionsDict = self.tableViewCellsDataSource[indexPath.row]
        let cellHeight = optionsDict.objectForKey(Constants.CellKeys.CELL_HEIGHT_KEY) as! CGFloat
        
        return cellHeight
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let optionsDict = self.tableViewCellsDataSource[indexPath.row]
        let cellHeight = optionsDict.objectForKey(Constants.CellKeys.CELL_HEIGHT_KEY) as! CGFloat
        
        return cellHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let optionsDict = self.tableViewCellsDataSource[indexPath.row]
        let cellType = OptionsCells(rawValue: (optionsDict.objectForKey(Constants.CellKeys.CELL_TYPE_KEY)) as! Int)!
        let cellIdentifier = optionsDict.objectForKey(Constants.CellKeys.CELL_IDENTIFIER_KEY) as! String
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        switch cellType {
        case .TEXT:
            (cell as! OptionsTextViewTableViewCell).delegate = self
            (cell as! OptionsTextViewTableViewCell).updateCell(optionsDict.objectForKey(Constants.CellKeys.OPTIONS_KEY) as! NSDictionary, indexPath: indexPath)
            break
            
        case .SLIDER:
            (cell as! OptionsSliderTableViewCell).delegate = self
            (cell as! OptionsSliderTableViewCell).updateCell(optionsDict.objectForKey(Constants.CellKeys.OPTIONS_KEY) as! NSDictionary, indexPath: indexPath)
            break
        case .SELECT:
            (cell as! OptionsSelectTableViewCell).updateCell(NSLocalizedString("CELL_OPTIONS_SELECT_COLOR", comment: ""))
            break
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let optionsDict = self.tableViewCellsDataSource[indexPath.row]
        let cellType = OptionsCells(rawValue: (optionsDict.objectForKey(Constants.CellKeys.CELL_TYPE_KEY)) as! Int)!
        
        if cellType == OptionsCells.SELECT {
            self.performSegueWithIdentifier("colorPickerSegue", sender: self)
        }
    }
}

extension OptionsTableViewController: OptionsTextViewTableViewCellProtocol {
    func textDidChange(text: String, indexPath: NSIndexPath) {
        self.updateTableViewCellsDataSource(indexPath, value: text)
        self.enteredText = text
    }
}

extension OptionsTableViewController: OptionsSliderTableViewCellProtocol {
    func sliderValueDidChange(value: Float, indexPath: NSIndexPath) {
        self.updateTableViewCellsDataSource(indexPath, value: value)
    }
}

extension OptionsTableViewController: ColorPickerViewControllerProtocol {
    func colorDidPick(color: String, indexPath: NSIndexPath) {
        self.updateTableViewCellsDataSource(indexPath, value: color)
    }
}
