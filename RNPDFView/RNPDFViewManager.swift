//
//  RNPDFViewManager.swift
//  RNPDFView
//
//  Created by Sibelius Seraphini on 3/10/16.
//  Copyright © 2016 RN. All rights reserved.
//

import UIKit

@objc(RNPDFViewManagerSwift)
class RNPDFViewManager : RCTViewManager {
    override func view() -> UIView! {
        return RNPDFView()
    }
}

