//
//  HandWritingsCollectionViewController.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 21/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "HandWritingCollectionViewCell"

class HandWritingsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var resultsController: NSFetchedResultsController!

    // MARK: - Controller lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.resultsController = HandWritings.getHandWritings()
        self.registerCollectionViewCells()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getHandWritings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI -
    
    private func registerCollectionViewCells() {
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Data source -
    
    /**
     Fetch all CoreData HandWritings objects NSFetchedResultsController and display them
     */
    private func getHandWritings() {
        do {
            try self.resultsController.performFetch()
            
            self.collectionView?.reloadData()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    // MARK: - Collection view stack -

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let count = self.resultsController.sections?.count {
            return count
        }
        
        return 0
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return HandWritingCollectionViewCell.cellSize
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HandWritingCollectionViewCell.cellIdentifier, forIndexPath: indexPath)
        let currentHandWriting = self.resultsController.objectAtIndexPath(indexPath) as! HandWritings
        
        (cell as! HandWritingCollectionViewCell).updateCell(currentHandWriting.title!, imageData: currentHandWriting.renderPNG)
        
        return cell
    }
}
