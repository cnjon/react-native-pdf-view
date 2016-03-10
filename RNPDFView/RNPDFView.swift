//
//  PDFView.swift
//  RNPDFView
//
//  Created by Sibelius Seraphini on 3/9/16.
//  Copyright © 2016 RN. All rights reserved.
//

import Foundation
import UIKit

@objc(RNPDFViewSwift)
class RNPDFView: UIView {
    var src: String? {
        willSet(newSrc) {
            self.reloadPDF()
        }
    }
    
    var pageNumber: Int? {
        willSet(newPageNumber) {
            self.reloadPDF()
        }
    }
    
    var pdfScrollView: PDFScrollView?
    var page: CGPDFPageRef?
//    var bridge: RCTBridge!
    
    @objc override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func insertReactSubview(view: UIView, atIndex: Int) {
        print("image cannot have any subviews")
        return
    }

    @objc func removeReactSubview(subview: UIView) {
        print("image cannot have any subviews");
        return
    }
    
//    @objc func setPageNumber(pageNumber: NSNumber) {
//        if !pageNumber.isEqualToNumber(self.pageNumber!) {
//            self.pageNumber = pageNumber as Int
//            self.reloadPDF()
//        }
//    }
//    
//    @objc func setSrc(src: String) {
//        if !src.isEqual(self.pageNumber) {
//            self.src = src
//            self.reloadPDF()
//        }
//    }
    
    @objc func reloadPDF() {
        if self.src == nil || self.src?.characters.count == 0 {
            print("nil src")
        } else {
            let pdfUrl: NSURL = NSURL.fileURLWithPath(self.src!)
            let pdf = CGPDFDocumentCreateWithURL( pdfUrl )
            let numberOfPages = CGPDFDocumentGetNumberOfPages(pdf) as Int
            if (self.pageNumber != nil && self.pageNumber <= numberOfPages) {
                self.page = CGPDFDocumentGetPage(pdf, self.pageNumber!)
            } else {
                self.page = CGPDFDocumentGetPage(pdf, 1)
            }
            
            print("self.page==NULL? \(self.page==nil)")
            
            self.pdfScrollView = PDFScrollView(frame: self.bounds)
            self.pdfScrollView?.PDFScale = 1
            self.pdfScrollView?.changePDFPage(self.page)
            self.addSubview(self.pdfScrollView!)
        }
    }
    
    @objc override func layoutSubviews() {
        super.layoutSubviews()
        let pageRect: CGRect = CGPDFPageGetBoxRect(self.page, CGPDFBox.MediaBox)
        let yScale: CGFloat = self.bounds.size.height/pageRect.size.height
        let xScale: CGFloat = self.bounds.size.width/pageRect.size.width
        let myScale: CGFloat = min(xScale, yScale)
        print("\(__FUNCTION__) self.myScale=\(myScale)")
        self.pdfScrollView!.frame = self.bounds
        self.pdfScrollView!.zoomScale = 1.0
        self.pdfScrollView!.PDFScale = myScale
        self.pdfScrollView!.tiledPDFView.bounds = self.bounds
        self.pdfScrollView!.tiledPDFView.myScale = myScale
        self.pdfScrollView?.tiledPDFView.layer.setNeedsDisplay()
    }
}