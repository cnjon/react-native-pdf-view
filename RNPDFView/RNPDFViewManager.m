//
//  RNPDFViewManager.m
//  App
//
//  Created by Sibelius Seraphini on 3/1/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import "RNPDFViewManager.h"
#import "RNPDFView.h"
#import <React/RCTEventDispatcher.h>

@implementation RNPDFViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [RNPDFView new];
}

RCT_EXPORT_VIEW_PROPERTY(src, NSString);
RCT_EXPORT_VIEW_PROPERTY(path, NSString);
RCT_EXPORT_VIEW_PROPERTY(pageNumber, NSNumber);
RCT_EXPORT_VIEW_PROPERTY(zoom, NSNumber);
RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock);

@end