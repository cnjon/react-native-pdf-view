//
//  ModelController.swift
//  ZoomingPDFViewer
//
//  Created by Fabio A. Camichel on 01.01.16.
//  Copyright © 2016 Fabio A. Camichel. All rights reserved.
//

import UIKit

/*
A controller object that manages a simple model -- a collection of month names.

The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.

There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
*/

class ModelController: NSObject, UIPageViewControllerDataSource {
    var pdf: CGPDFDocumentRef!
    var numberOfPages: Int = 0
    
    override init() {
        super.init()
        // Create the data model.
        let pdfURL = NSBundle.mainBundle().URLForResource("input_pdf.pdf", withExtension: nil)
        self.pdf = CGPDFDocumentCreateWithURL(pdfURL)
        self.numberOfPages = CGPDFDocumentGetNumberOfPages(self.pdf) as Int
        if (self.numberOfPages % 2 == 1) {
            self.numberOfPages++
        }
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController {
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.pageNumber = index + 1
        dataViewController.pdf = self.pdf
        return dataViewController
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return viewController.pageNumber - 1
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        
        if (index == self.numberOfPages) {
            return nil
        }
        
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
}

