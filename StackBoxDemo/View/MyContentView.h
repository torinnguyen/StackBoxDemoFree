//
//  SBViewWrapper.h
//  StackBoxDemo
//
//  Created by Torin on 11/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBDataModel.h"
#import "SBContentViewBase.h"

@class MyContentView;

@protocol MyContentViewDelegate <NSObject>
@optional
- (void)myContentView:(MyContentView*)myContentView onLeftButton:(UIButton*)sender;
- (void)myContentView:(MyContentView*)myContentView onRightButton:(UIButton*)sender;
- (void)myContentView:(MyContentView*)myContentView onLeftSwitch:(UISwitch*)sender;
@end

@interface MyContentView : SBContentViewBase

- (void)configureWithModel:(SBDataModel*)theModel;

@end
