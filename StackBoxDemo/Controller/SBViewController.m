//
//  SBViewController.m
//  StackBoxDemo
//
//  Created by Torin on 11/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import "SBViewController.h"
#import "StackBox.h"
#import "SBDataProvider.h"
#import "MyContentView.h"

@interface SBViewController ()
@property (nonatomic, strong) StackBox *stackBox1;
@property (nonatomic, strong) StackBox *stackBox2;
@property (nonatomic, strong) SBDataProvider *dataProvider;
@end

@implementation SBViewController

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setupData];
  
  BOOL isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
  if (isPad)      [self setupPad];
  else            [self setupPhone];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return YES;
}


#pragma mark - StackBoxDataSource

- (NSUInteger)stackBox:(StackBox*)stackBox numberOfItems:(NSInteger)dummy
{
  return [self.dataProvider count];
}

/*
 * Supply content view to each item/card.
 * On the first time (for each item/card), reusable view will be nil, you have to create it
 * The returned view must be a subclass of SBContentViewBase
 */
- (SBContentViewBase*)contentViewForItemIndex:(NSInteger)index withReusableView:(SBContentViewBase*)view bounds:(CGRect)bounds
{
  SBDataModel *model = [self.dataProvider objectAtIndex:index];
  if (model == nil)
    return view;
  
  //Reuse, from 2nd time onwards
  MyContentView *myView = nil;
  if ([view isKindOfClass:[MyContentView class]])
    myView = (MyContentView*)myView;
  
  //First time, view is nil
  if (myView == nil)
    myView = [[MyContentView alloc] initWithFrame:bounds];
  
  myView.delegate = self;
  [myView configureWithModel:model];
  
  return myView;
}

- (void)setupData
{
  self.dataProvider = [[SBDataProvider alloc] init];
}

- (void)setupPhone
{
  self.stackBox1 = [[StackBox alloc] initWithFrame:self.view.bounds];
  self.stackBox1.delegate = self;
  self.stackBox1.dataSource = self;
  self.stackBox1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.stackBox1];
  [self.stackBox1 reload];
}

- (void)setupPad
{
  self.stackBox1 = [[StackBox alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height)];
  self.stackBox1.delegate = self;
  self.stackBox1.dataSource = self;
  self.stackBox1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.stackBox1];
  [self.stackBox1 showDebugBorder:YES];
  [self.stackBox1 reload];
  
  self.stackBox2 = [[StackBox alloc] initWithFrame:CGRectMake(320, 0, 448, self.view.bounds.size.height/2)];
  self.stackBox2.delegate = self;
  self.stackBox2.dataSource = self;
  self.stackBox2.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
  [self.view addSubview:self.stackBox2];
  [self.stackBox2 showDebugBorder:YES];
  [self.stackBox2 reload];
}



#pragma mark - StackBoxDelegate

- (void)stackBox:(StackBox*)stackBox didSnapToIndex:(CGFloat)index
{
  [self updateStackBoxTitle:stackBox];
  
  //Sanity check
  SBWrapperView *view = (SBWrapperView*)[stackBox getItemView:index];
  if ([view isKindOfClass:[SBWrapperView class]] == NO)
    return;
  
  [view showExtendedMode:0.4 delay:0.2];
}

- (void)stackBox:(StackBox*)stackBox willBeginToScroll:(CGFloat)index
{
  //Sanity check
  SBWrapperView *view = (SBWrapperView*)[stackBox getItemView:roundf(index)];
  if ([view isKindOfClass:[SBWrapperView class]] == NO)
    return;
  
  [view showSummaryMode:0.4];
}

- (void)stackBox:(StackBox*)stackBox didScroll:(CGFloat)index
{
  [self updateStackBoxTitle:stackBox];
}

- (void)stackBox:(StackBox*)stackBox didChangeIndex:(CGFloat)index
{
  [self updateStackBoxTitle:stackBox];
}


#pragma mark - MyContentViewDelegate

- (void)myContentView:(MyContentView*)myContentView onLeftButton:(UIButton*)sender
{
  NSLog(@"onLeftButton (index: %d)", myContentView.tag);
}

- (void)myContentView:(MyContentView*)myContentView onRightButton:(UIButton*)sender
{
  NSLog(@"onRightButton (index: %d)", myContentView.tag);
}



#pragma mark - Helpers
                             
- (void)updateStackBoxTitle:(StackBox*)stackBox
{
  NSInteger index = roundf(stackBox.controlIndex);
  if (index < 0) {
    stackBox.titleText = [NSString stringWithFormat:@"Stackbox v%@", [StackBox version]];
    return;
  }
  
  stackBox.titleText = [NSString stringWithFormat:@"Stackbox (%d/%d)", index+1, [self.dataProvider count]];
}


@end
