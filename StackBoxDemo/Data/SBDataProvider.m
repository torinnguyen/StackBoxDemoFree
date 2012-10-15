//
//  SBDataProvider.m
//  StackBoxDemo
//
//  Created by Torin on 14/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import "SBDataProvider.h"

@interface SBDataProvider()
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation SBDataProvider

- (id)init
{
  self = [super init];
  if (self == nil)
    return self;
  
  self.dataArray = [[NSMutableArray alloc] init];
  
  //Read JSON file
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"name_list" ofType:@"json"];
  NSData *fileData = [[NSFileManager defaultManager] contentsAtPath:filePath];
  if (fileData == nil) {
    NSLog(@"JSON file couldn't be read!");
    return self;
  }

  //iOS5 JSON Framework
  NSError *error;
  NSDictionary* jsonArray = [NSJSONSerialization
                             JSONObjectWithData:fileData
                             options:kNilOptions
                             error:&error];
  
  //Convert to NSDictionary to data model objects
  for (NSDictionary *personDict in jsonArray) {
    SBDataModel *model = [[SBDataModel alloc] initWithDictionary:personDict];
    [self.dataArray addObject:model];
  }
  
  return self;
}

- (NSUInteger)count
{
  return [self.dataArray count];
}

- (SBDataModel*)objectAtIndex:(NSInteger)index
{
  NSUInteger count = [self.dataArray count];
  return [self.dataArray objectAtIndex:index % count];
}

@end
