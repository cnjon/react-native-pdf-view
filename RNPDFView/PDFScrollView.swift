//
//  PDFScrollView.swift
//  ZoomingPDFViewer
//
//  Created by Fabio A. Camichel on 01.01.16.
//  Copyright © 2016 Fabio A. Camichel. All rights reserved.
//

import UIKit

class PDFScrollView: UIScrollView, UIScrollViewDelegate {
    var pageRect = CGRect()
    var backgroundImageView: UIView!
    var tiledPDFView: TiledPDFView!
    var oldTiledPDFView: TiledPDFView!
    var PDFScale = CGFloat()
    var PDFPage: CGPDFPageRef!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() {
        //pretty_function()
        self.decelerationRate = UIScrollViewDecelerationRateFast
        self.delegate = self;
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 5;
        self.minimumZoomScale = 0.25;
        self.maximumZoomScale = 5;
        self.backgroundImageView = UIView(frame: self.frame)
        self.oldTiledPDFView = TiledPDFView(frame:self.pageRect, scale: PDFScale)
    }
    
    func changePDFPage(PDFPage: CGPDFPageRef?) {
        self.PDFPage = PDFPage
        
        // PDFPage is nil if we're requested to draw a padded blank page by the parent UIPageViewController
        if (PDFPage == nil) {
            self.pageRect = self.bounds
        }
        else {
            self.pageRect = CGPDFPageGetBoxRect(self.PDFPage, CGPDFBox.MediaBox )
            
            self.PDFScale = self.frame.size.width / self.pageRect.size.width;
            self.pageRect = CGRectMake(self.pageRect.origin.x, self.pageRect.origin.y, self.pageRect.size.width * self.PDFScale, self.pageRect.size.height * self.PDFScale)
            
        }
        // Create the TiledPDFView based on the size of the PDF page and scale it to fit the view.
        self.replaceTiledPDFViewWithFrame(self.pageRect)
    }
    
    // Use layoutSubviews to center the PDF page in the view.
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Center the image as it becomes smaller than the size of the screen.
        
        let boundsSize = self.bounds.size
        var frameToCenter:CGRect = self.tiledPDFView.frame
        
        // Center horizontally.
        
        if (frameToCenter.size.width < boundsSize.width) {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        }
        else {
            frameToCenter.origin.x = 0
        }
        
        // Center vertically.
        
        if (frameToCenter.size.height < boundsSize.height) {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        }
        else {
            frameToCenter.origin.y = 0
        }
        
        self.tiledPDFView.frame = frameToCenter
        self.backgroundImageView.frame = frameToCenter
        
        /*
        To handle the interaction between CATiledLayer and high resolution screens, set the tiling view's contentScaleFactor to 1.0.
        If this step were omitted, the content scale factor would be 2.0 on high resolution screens, which would cause the CATiledLayer to ask for tiles of the wrong scale.
        */
        
        self.tiledPDFView.contentScaleFactor = 1.0;
        
    }
    
    /*
    A UIScrollView delegate callback, called when the user starts zooming.
    Return the current TiledPDFView.
    */
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.tiledPDFView
    }
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        //print(pretty_function_string() + " scrollview.zoomScale = \(self.zoomScale)")
        // Remove back tiled view.
        self.oldTiledPDFView.removeFromSuperview()
        
        // Set the current TiledPDFView to be the old view.
        self.oldTiledPDFView = self.tiledPDFView
    }
    
    /*
    A UIScrollView delegate callback, called when the user begins zooming.
    When the user begins zooming, remove the old TiledPDFView and set the current TiledPDFView to be the old view so we can create a new TiledPDFView when the zooming ends.
    */
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        //print(pretty_function_string() + "BEFORE " + " PDFScale = \(PDFScale)")
        
        // Set the new scale factor for the TiledPDFView.
        PDFScale *= scale
        //print(pretty_function_string() + "AFTER " + " PDFScale = \(PDFScale)" + "newFrame = \(self.oldTiledPDFView.frame)")
        // Create a new tiled PDF View at the new scale
        self.replaceTiledPDFViewWithFrame(self.oldTiledPDFView.frame)
    }
    
    func replaceTiledPDFViewWithFrame(frame: CGRect) {
        // Create a new tiled PDF View at the new scale
        let t = TiledPDFView(frame: frame, scale: PDFScale)
        t.pdfPage = PDFPage
        // Add the new TiledPDFView to the PDFScrollView.
        self.addSubview(t)
        self.tiledPDFView = t
    }
}

