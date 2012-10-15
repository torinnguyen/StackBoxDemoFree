//
//  SBDataProvider.h
//  StackBoxDemo
//
//  Created by Torin on 14/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBDataModel.h"

@interface SBDataProvider : NSObject

- (NSUInteger)count;

- (SBDataModel*)objectAtIndex:(NSInteger)index;

@end
