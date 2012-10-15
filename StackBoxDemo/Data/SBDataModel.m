//
//  DataModel.m
//  StackBoxDemo
//
//  Created by Torin on 14/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import "SBDataModel.h"
#import <objc/runtime.h>

@implementation SBDataModel

- (id)initWithDictionary:(NSDictionary*)dict
{
  self = [super init];
  if (self == nil)
    return self;
  
  return [self updateWithDictionary:dict];
}

/*
 * This magic code assign properties in a NSDictionary into @property
 */
- (id)updateWithDictionary:(NSDictionary*)dict
{
  //List of ivars
  unsigned int outCount;
  id class = objc_getClass([NSStringFromClass([self class]) UTF8String]);
  Ivar *ivars = class_copyIvarList(class, &outCount);
  
  //For each top-level property in the dictionary
  NSEnumerator *enumerator = [dict keyEnumerator];
  id dictKey;
  while ((dictKey = [enumerator nextObject]))
  {
    id dictValue = [dict objectForKey:dictKey];
    
    //Special case for "id" property
    if ([dictKey isEqualToString:@"id"])
      dictKey = @"ID";
    
    //If it match our ivar name, then set it
    for (unsigned int i = 0; i < outCount; i++)
    {
      Ivar ivar = ivars[i];
      NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
      NSString *ivarNameTrim = [ivarName substringFromIndex:1];
      NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
      
      if ([dictKey isEqualToString:ivarNameTrim] == NO)
        continue;
      
      //Empty value
      if ([dictValue isKindOfClass:[NSNull class]] ||
          ([dictValue isKindOfClass:[NSString class]] && [dictValue isEqualToString:@"null"])) {
        continue;
      }
      
      //Convert unix timestamp number to NSDate
      if (dictValue != nil
          && [dictValue isEqual:[NSNull null]] == NO
          && [ivarType isEqual:@"@\"NSDate\""])
      {
        NSDate *dateTimeValue = [NSDate dateWithTimeIntervalSince1970:[dictValue longLongValue]];
        dictValue = dateTimeValue;
      }
      
      [self setValue:dictValue forKey:ivarName];
    }
  }
  
  free(ivars);
  return self;
}

@end
