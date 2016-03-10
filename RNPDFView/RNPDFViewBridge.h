//
//  RNPDFViewBridge.h
//  RNPDFView
//
//  Created by Sibelius Seraphini on 3/10/16.
//  Copyright © 2016 RN. All rights reserved.

#import "RCTView.h"

@interface RNPDFViewBridge : RCTView

@property (nonatomic, assign) NSString *src;
@property (nonatomic, assign) NSNumber *pageNumber;

@end