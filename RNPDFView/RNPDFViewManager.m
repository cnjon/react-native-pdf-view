//
//  RNPDFViewManager.m
//  App
//
//  Created by Sibelius Seraphini on 3/1/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridge.h"
#import "RNPDFViewManager.h"
#import "RNPDFView.h"

@implementation RNPDFViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[RNPDFView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(src, NSString);
RCT_EXPORT_VIEW_PROPERTY(pageNumber, NSNumber);

@end