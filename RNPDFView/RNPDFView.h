//
//  RNPDFView.h
//  App
//
//  Created by Sibelius Seraphini on 3/1/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RCTEventDispatcher.h"

@class RCTEventDispatcher;

@interface RNPDFView : UIView

@property (nonatomic, assign) NSString *src;
@property (nonatomic, assign) NSNumber *pageNumber;

@end