//
//  StackBox.h
//  StackBoxDemo
//
//  Created by Torin on 11/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBWrapperView.h"
#import "SBContentViewBase.h"

@class StackBox;

@protocol StackBoxDataSource <NSObject>

/*
 * Protocol to return the number of items/cards
 * Please ignore the dummy parameter, reserved for future use
 */
- (NSUInteger)stackBox:(StackBox*)stackBox numberOfItems:(NSInteger)dummy;

/*
 * Supply content view to each item/card.
 * On the first time (for each item/card), reusable view will be nil, you have to create it
 * The returned view must be a subclass of SBContentViewBase
 */
- (SBContentViewBase*)contentViewForItemIndex:(NSInteger)index withReusableView:(SBContentViewBase*)view bounds:(CGRect)bounds;

@end

//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------

@protocol StackBoxDelegate <NSObject>
@optional
- (void)stackBox:(StackBox*)stackBox didSnapToIndex:(CGFloat)index;
- (void)stackBox:(StackBox*)stackBox willSnapToIndex:(CGFloat)index;
- (void)stackBox:(StackBox*)stackBox willBeginToScroll:(CGFloat)index;
- (void)stackBox:(StackBox*)stackBox didScroll:(CGFloat)index;
- (void)stackBox:(StackBox*)stackBox didChangeIndex:(CGFloat)index;
@end

//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------

@interface StackBox : UIView

@property (nonatomic, assign) CGFloat controlIndex;
@property (nonatomic, unsafe_unretained) id delegate;
@property (nonatomic, unsafe_unretained) id dataSource;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger numVisibleItems;
@property (nonatomic, assign) BOOL autoAdjustNumVisibleItems;

+ (NSString*)version;

- (void)reload;
- (void)showDebugBorder:(BOOL)show;

- (BOOL)hasItemView:(NSInteger)index;
- (UIView*)getItemView:(NSInteger)index;

@end
