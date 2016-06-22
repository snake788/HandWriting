//
//  NewHandWritingViewController.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit
import SwiftSpinner

let fontSelectionCell = "fontSelectionCell"

class NewHandWritingViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var allHandWritings : Array<HandWriting>? {
        didSet {
            self.tableView.reloadData()
            self.animateSubviews()
        }
    }
    var isFirstLayout: Bool = true
    
    // MARK: - Controller lifecyle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
        self.registerTableViewCells()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.isFirstLayout {
            self.isFirstLayout = false
            
            self.fetchAllHandWritings()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI -
    
    private func updateUI() {
        self.updateSegmentedControl()
        self.title = NSLocalizedString("NEW_HANDWRITING_VC_TITLE", comment: "")
        self.segmentedControl.alpha = 0.0
    }

    private func updateSegmentedControl() {
        self.segmentedControl.setTitle(NSLocalizedString("SEGMENTED_CONTROL_SEGMENT_TITLE", comment: ""), forSegmentAtIndex: 0)
        self.segmentedControl.setTitle(NSLocalizedString("SEGMENTED_CONTROL_SEGMENT_NEATNESS", comment: ""), forSegmentAtIndex: 1)
        self.segmentedControl.setTitle(NSLocalizedString("SEGMENTED_CONTROL_SEGMENT_WIDTH", comment: ""), forSegmentAtIndex: 2)
    }
    
    private func registerTableViewCells() {
        self.tableView.registerNib(UINib(nibName: FontSelectionTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: FontSelectionTableViewCell.cellIdentifier)
    }
    
    private func animateSubviews() {
        UIView.animateWithDuration(3.0) {
            self.segmentedControl.alpha = 1.0
        }
        
        self.animateTableViewCells()
    }
    
    private func animateTableViewCells() {
        let cells = self.tableView.visibleCells
        let tableViewHeight = self.tableView.bounds.size.height
            
        for cell in cells {
            cell.transform = CGAffineTransformMakeTranslation(0, tableViewHeight)
        }
            
        var index = 0
            
        for cell in cells {
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)
                
            index += 1
        }
    }
    
    // MARK: - Segmented control -
    
    @IBAction func segmentedControlDidTouched(sender: UISegmentedControl) {
        if self.allHandWritings?.count > 0 {
            switch sender.selectedSegmentIndex {
            case 0:
                self.allHandWritings?.sortInPlace({ (hw1: HandWriting, hw2: HandWriting) -> Bool in
                    return hw1.title < hw2.title
                })
                break
            case 1:
                self.allHandWritings?.sortInPlace({ (hw1: HandWriting, hw2: HandWriting) -> Bool in
                    return hw1.ratingNeatness! < hw2.ratingNeatness!
                })
                break
            case 2:
                self.allHandWritings?.sortInPlace({ (hw1: HandWriting, hw2: HandWriting) -> Bool in
                    return hw1.ratingCharacterWidth! < hw2.ratingCharacterWidth!
                })
                break
            default:
                break
            }
        }
    }
    
    // MARK: - Navigation -
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "optionsSegue" {
            let selectedIndexPath = self.tableView.indexPathForSelectedRow
            let optionsTVC = segue.destinationViewController as! OptionsTableViewController
            optionsTVC.handWritingSelected = self.allHandWritings![(selectedIndexPath?.row)!]
        }
    }
    
    // MARK: - Data source -
    
    /**
     Fetch all handwritings objects through WSManager and display them
     */
    private func fetchAllHandWritings() {
        SwiftSpinner.show(NSLocalizedString("SWIFT_SPINNER_LOADING_HANDWRITINGS", comment: ""), animated: true)
        
        WSManager.fetchAllHandWritings { (allHandWritings, error) in
            SwiftSpinner.hide()
            
            if error != nil {
                self.presentViewController(AlertHelper.WSError(error), animated: true, completion: nil)
            } else {
                self.allHandWritings = allHandWritings
            }
        }
    }
}

extension NewHandWritingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.allHandWritings?.count {
            return count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return FontSelectionTableViewCell.cellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FontSelectionTableViewCell.cellIdentifier, forIndexPath: indexPath) as! FontSelectionTableViewCell
        let currentHandWriting = self.allHandWritings![indexPath.row]
        
        cell.updateCell(currentHandWriting)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("optionsSegue", sender: self)
    }
}
