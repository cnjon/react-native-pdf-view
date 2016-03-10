//
//  RNPDFViewBridge.m
//  RNPDFView
//
//  Created by Sibelius Seraphini on 3/10/16.
//  Copyright © 2016 RN. All rights reserved.
//

#import "RCTBridgeModule.h"
#import "RCTViewManager.h"
#import "RCTView.h"
#import "RNPDFViewBridge.h"

@interface RCT_EXTERN_MODULE(RNPDFViewManagerSwift, RCTViewManager)
//
//RCT_EXPORT_VIEW_PROPERTY(src, NSString);
//RCT_EXPORT_VIEW_PROPERTY(pageNumber, NSNumber);
//
//
//@end

@interface RNPDFViewManager : RCTView

@property (nonatomic, assign) NSString *src;
@property (nonatomic, assign) NSNumber *pageNumber;

@end

@implementation RNPDFViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    RNPDFViewSwift* view = [[RNPDFViewSwift alloc] init]
    return [[RNPDFView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(src, NSString);
RCT_EXPORT_VIEW_PROPERTY(pageNumber, NSNumber);

@end