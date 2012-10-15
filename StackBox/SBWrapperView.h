//
//  SBViewWrapper.h
//  StackBoxDemo
//
//  Created by Torin on 11/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBContentViewBase.h"

@interface SBWrapperView : UIView
@property (nonatomic, strong) SBContentViewBase * contentView;

- (void)reset;
- (void)configureWithTag:(NSInteger)newTag;

- (void)showSummaryMode:(CGFloat)duration;
- (void)showExtendedMode:(CGFloat)duration delay:(CGFloat)delay;

- (void)updateTransformWithM34:(CGFloat)m34 scale:(CGFloat)scale angle:(CGFloat)angle;

@end
