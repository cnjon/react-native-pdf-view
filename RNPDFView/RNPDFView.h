//
//  RNPDFView.h
//  App
//
//  Created by Sibelius Seraphini on 3/1/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <React/RCTEventDispatcher.h>
#import "UIView+React.h"

@class RCTEventDispatcher;

@interface RNPDFView : UIView

@property(nonatomic, strong) NSString *src;
@property(nonatomic, strong) NSString *path;
@property(nonatomic, strong) NSNumber *pageNumber;
@property(nonatomic, strong) NSNumber *zoom;
@property(nonatomic, strong) NSNumber *borderWidth;
@property(nonatomic, strong) UIColor *backgroundColor;

@property(nonatomic, copy) RCTBubblingEventBlock onChange;

@end
