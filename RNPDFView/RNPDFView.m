//
//  RNPDFView.m
//  App
//
//  Created by Sibelius Seraphini on 3/1/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "RCTBridgeModule.h"
#import "RCTEventDispatcher.h"
#import "UIView+React.h"
#import "RCTLog.h"

#import "TiledPDFView.h"
#import "PDFScrollView.h"
#import "RNPDFView.h"

@implementation RNPDFView {
  UILabel *_titleLabel;
  CGPDFDocumentRef _pdf;
  int _numberOfPages;
  CGPDFPageRef _page;
  CGFloat _PDFScale;
  TiledPDFView *_tiledPDFView;
  PDFScrollView *_pdfScrollView;
}

- (instancetype)init
{
  if ((self = [super init])) {
    _tiledPDFView = [[TiledPDFView alloc] initWithFrame:self.bounds scale:_PDFScale];
  }
  
  return self;
}

#pragma mark - React View Management

- (void)insertReactSubview:(UIView *)view atIndex:(NSInteger)atIndex
{
  RCTLogError(@"image cannot have any subviews");
  return;
}

- (void)removeReactSubview:(UIView *)subview
{
  RCTLogError(@"image cannot have any subviews");
  return;
}

- (void)reloadPdf
{
  if (self.path == (id)[NSNull null] || self.path.length == 0) {
    NSLog(@"null path");
  } else {
    NSLog(@"not null: %@", self.path);
  
    NSURL *pdfURL = [NSURL fileURLWithPath:self.path];
    _pdf = CGPDFDocumentCreateWithURL( (__bridge CFURLRef) pdfURL );
    _numberOfPages = (int)CGPDFDocumentGetNumberOfPages( _pdf );

    if (self.pageNumber != nil && [self.pageNumber intValue] <= _numberOfPages) {
      _page = CGPDFDocumentGetPage( _pdf, [self.pageNumber unsignedIntValue] );
    } else {
      _page = CGPDFDocumentGetPage( _pdf, 1 );
    }
    
    NSLog(@"self.page==NULL? %@",_page==NULL?@"yes":@"no");
    
    _pdfScrollView = [[PDFScrollView alloc] initWithFrame:self.bounds];
    _pdfScrollView.PDFScale = 1;
    [_pdfScrollView setPDFPage:_page];
    [self addSubview:_pdfScrollView];
  }
}

- (void)setPageNumber:(NSNumber *)pageNumber
{
  if (![pageNumber isEqual:_pageNumber]) {
    NSLog(@"setPageNumber %@ -> %@", _pageNumber, pageNumber);
    _pageNumber = [pageNumber copy];
    [self reloadPdf];
  }
}

- (void)setSrc:(NSString *)src
{
  if (![src isEqual:_path]) {
    _path = [src copy];
    [self reloadPdf];
  }
}

- (void)setPath:(NSString *)path
{
    if (![path isEqual:_path]) {
        _path = [path copy];
        [self reloadPdf];
    }
}

- (void)setZoom:(NSNumber *)zoom
{
    if (![zoom isEqual:_zoom]) {
        NSLog(@"setZoom %@ -> %@", _zoom, zoom);
        _zoom = [zoom copy];
        [self reloadPdf];
    }
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  CGRect pageRect = CGPDFPageGetBoxRect( _page, kCGPDFMediaBox );
  CGFloat yScale = self.bounds.size.height/pageRect.size.height;
  CGFloat xScale = self.bounds.size.width/pageRect.size.width;
  CGFloat myScale = MIN( xScale, yScale );
  NSLog(@"%s self.myScale=%f",__PRETTY_FUNCTION__, myScale);
  
  _pdfScrollView.frame = self.bounds;
  _pdfScrollView.zoomScale = (_zoom == NULL ? 1.0 : [_zoom doubleValue]);
  _pdfScrollView.PDFScale = myScale;
  _pdfScrollView.tiledPDFView.bounds = self.bounds;
  _pdfScrollView.tiledPDFView.myScale = myScale;
  [_pdfScrollView.tiledPDFView.layer setNeedsDisplay];
  NSLog(@"onChange==NULL? %@",_onChange==NULL?@"yes":@"no");
  if(_onChange){
    NSLog(@"onChange %d", _numberOfPages);
    _onChange(@{ @"message": @(_numberOfPages) });
  }
}

@end