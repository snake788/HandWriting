//
//  RenderViewController.swift
//  HandWriting
//
//  Created by Aurélien WOLFERT on 20/06/2016.
//  Copyright © 2016 snake788. All rights reserved.
//

import UIKit
import SwiftSpinner

class RenderViewController: UIViewController {
    @IBOutlet var barButtonItemSave: UIBarButtonItem!
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var renderOptions: RenderOptions!
    var renderPNGData: NSData?
    
    // MARK: - Controller lifecyle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handWritingsDelegate = self
        
        self.updateUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getRenderPNG()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UI -
    
    private func updateUI() {
        self.navigationItem.title = "PNG"
        self.navigationItem.rightBarButtonItem = self.barButtonItemSave
    }
    
    private func setScrollViewZoomScale() {
        let imageViewSize = self.imageView.bounds.size
        let scrollViewSize = self.scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
    
        self.scrollView.minimumZoomScale = min(widthScale, heightScale)
        self.scrollView.zoomScale = 1.0
    }
    
    // MARK: - Bar button item action -
    
    @IBAction func barButtonItemActionSaveTouched(sender: UIBarButtonItem) {
        guard self.renderPNGData != nil else { return }
        
        HandWritings.addRenderPNG(self.renderPNGData!, title: self.renderOptions.text!)
    }
    
    // MARK: - Data source -
    
    /**
     Fetch the rendered PNG through WSManager and display it via an UIImageViews contained in a UIScrollView
     */
    private func getRenderPNG() {
        SwiftSpinner.show(NSLocalizedString("SWIFT_SPINNER_LOADING_RENDER", comment: ""), animated: true)
        
        WSManager.getRenderPNG(self.renderOptions) { (renderPNG, error) in
            SwiftSpinner.hide()
            
            if error != nil {
                self.imageView.image = nil
                
                self.presentViewController(AlertHelper.WSError(error), animated: true, completion: nil)
            } else {
                if let finalRenderPNG = renderPNG {
                    self.renderPNGData = finalRenderPNG
                    
                    self.imageView = UIImageView(image: UIImage(data: finalRenderPNG))
                    
                    self.scrollView = UIScrollView(frame: self.view.bounds)
                    self.scrollView.backgroundColor = UIColor.clearColor()
                    self.scrollView.contentSize = self.imageView.bounds.size
                    self.scrollView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
                    self.scrollView.delegate = self
                    
                    self.setScrollViewZoomScale()
                    
                    self.scrollView.addSubview(self.imageView)
                    self.view.addSubview(self.scrollView)
                    
                    self.scrollView.contentInset = UIEdgeInsetsMake(100.0, 100.0, 0, 0)
                }
            }
        }
    }
}

extension RenderViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let imageViewSize = self.imageView.frame.size
        let scrollViewSize = self.scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}

extension RenderViewController: HandWritingsProtocol {
    func coreDataHasAddHandWriting() {
        self.navigationController?.popViewControllerAnimated(true)
        
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.NotificationKeys.USER_HAS_ADDED_HANDWRITING_TO_CORE_DATA, object: nil)
    }
}
