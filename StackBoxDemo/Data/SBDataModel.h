//
//  DataModel.h
//  StackBoxDemo
//
//  Created by Torin on 14/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBDataModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSNumber *type;
@property (nonatomic, copy) NSNumber *onOff;

- (id)initWithDictionary:(NSDictionary*)dict;

@end
