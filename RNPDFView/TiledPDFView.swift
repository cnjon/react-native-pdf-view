//
//  TiledPDFView.swift
//  ZoomingPDFViewer
//
//  Created by Fabio A. Camichel on 01.01.16.
//  Copyright © 2016 Fabio A. Camichel. All rights reserved.
//

import UIKit

class TiledPDFView: UIView {
    var pdfPage: CGPDFPageRef?
    var myScale: CGFloat!
    
    // Create a new TiledPDFView with the desired frame and scale.
    init(frame: CGRect, scale: CGFloat) {
        super.init(frame: frame)
        let tiledLayer = CATiledLayer(layer: self)
        /*
        levelsOfDetail and levelsOfDetailBias determine how the layer is rendered at different zoom levels. This only matters while the view is zooming, because once the the view is done zooming a new TiledPDFView is created at the correct size and scale.
        */
        tiledLayer.levelsOfDetail = 4
        tiledLayer.levelsOfDetailBias = 3
        tiledLayer.tileSize = CGSizeMake(512.0, 512.0)
        
        self.myScale = scale
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Draw the CGPDFPageRef into the layer at the correct scale.
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        //print(pretty_function_string() + "myScale: \(myScale)")
        
        // Fill the background with white.
        CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0)
        CGContextFillRect(ctx, self.bounds)
        
        // Print a blank page and return if our page is nil.
        if (pdfPage == nil) {
            return
        }
        
        CGContextSaveGState(ctx)
        // Flip the context so that the PDF page is rendered right side up.
        CGContextTranslateCTM(ctx, 0.0, self.bounds.size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        
        // Scale the context so that the PDF page is rendered at the correct size for the zoom level.
        CGContextScaleCTM(ctx, self.myScale, self.myScale)
        CGContextDrawPDFPage(ctx, self.pdfPage)
        CGContextRestoreGState(ctx)
    }
}

