//
//  SBViewWrapper.m
//  StackBoxDemo
//
//  Created by Torin on 11/10/12.
//  Copyright (c) 2012 Torin Nguyen. All rights reserved.
//

#import "MyContentView.h"
#import <QuartzCore/QuartzCore.h>

#define IMAGE_SIZE          64
#define IMAGE_PADDING       18
#define TEXT_PADDING        8

@interface MyContentView()
@property (nonatomic, strong) UIImageView * backgroundImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * subtitleLabel;
@property (nonatomic, strong) UILabel * descriptionLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UISwitch *leftSwitch;
@property (nonatomic, strong) UILabel *leftSwitchLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) SBDataModel * model;
@end

@implementation MyContentView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self == nil)
    return self;

  self.backgroundColor = [UIColor clearColor];
  
  //Background image
  UIImage *backgroundImage = [UIImage imageNamed:@"stackbox_card"];
  self.backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
  self.backgroundImageView.frame = self.bounds;
  self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:self.backgroundImageView];
  
  //Thumbnail image
  self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(IMAGE_PADDING, IMAGE_PADDING, IMAGE_SIZE, IMAGE_SIZE)];
  self.imageView.contentMode = UIViewContentModeScaleAspectFill;
  self.imageView.clipsToBounds = YES;
  self.imageView.backgroundColor = [UIColor clearColor];
  self.imageView.layer.cornerRadius = 16;
  self.imageView.layer.shadowOpacity = 0.8;
  self.imageView.layer.shadowRadius = 2;
  self.imageView.layer.shadowColor = [[UIColor whiteColor] CGColor];
  self.imageView.layer.shadowOffset = CGSizeZero;
  [self addSubview:self.imageView];
  
  //Title
  self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
  self.titleLabel.backgroundColor = [UIColor clearColor];
  self.titleLabel.textAlignment = UITextAlignmentLeft;
  self.titleLabel.textColor = [UIColor darkTextColor];
  self.titleLabel.numberOfLines = 2;
  self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
  self.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
  self.titleLabel.minimumFontSize = 11;
  self.titleLabel.clipsToBounds = NO;
  [self addSubview:self.titleLabel];
  
  //Subtitle
  self.subtitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
  self.subtitleLabel.backgroundColor = [UIColor clearColor];
  self.subtitleLabel.textAlignment = UITextAlignmentLeft;
  self.subtitleLabel.textColor = [UIColor darkGrayColor];
  self.subtitleLabel.numberOfLines = 2;
  self.subtitleLabel.lineBreakMode = UILineBreakModeWordWrap;
  self.subtitleLabel.font = [UIFont systemFontOfSize:14];
  self.subtitleLabel.minimumFontSize = 9;
  self.subtitleLabel.clipsToBounds = NO;
  [self addSubview:self.subtitleLabel];
  
  //Description
  self.descriptionLabel = [[UILabel alloc] initWithFrame:self.bounds];
  self.descriptionLabel.backgroundColor = [UIColor clearColor];
  self.descriptionLabel.textAlignment = UITextAlignmentLeft;
  self.descriptionLabel.font = [UIFont systemFontOfSize:14];
  self.descriptionLabel.textColor = [UIColor darkGrayColor];
  self.descriptionLabel.numberOfLines = 0;
  self.descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
  self.descriptionLabel.clipsToBounds = NO;
  [self insertSubview:self.descriptionLabel aboveSubview:self.backgroundImageView];
  
  //Left button
  /*
  self.leftButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
  self.leftButton.frame = CGRectMake(IMAGE_PADDING,
                                     CGRectGetHeight(self.bounds)-IMAGE_PADDING-32, 32, 32);
  self.leftButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
  self.leftButton.showsTouchWhenHighlighted = YES;
  self.leftButton.hidden = YES;
  [self.leftButton addTarget:self action:@selector(onLeftButton:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.leftButton];
  
  //Left switch label
  self.leftSwitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(IMAGE_PADDING,
                                                                  CGRectGetHeight(self.bounds)-IMAGE_PADDING-32, 80, 32)];
  self.leftSwitchLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
  self.leftSwitchLabel.backgroundColor = [UIColor clearColor];
  self.leftSwitchLabel.textAlignment = UITextAlignmentLeft;
  self.leftSwitchLabel.font = [UIFont systemFontOfSize:14];
  self.leftSwitchLabel.textColor = [UIColor darkGrayColor];
  self.leftSwitchLabel.numberOfLines = 0;
  self.leftSwitchLabel.lineBreakMode = UILineBreakModeWordWrap;
  self.leftSwitchLabel.clipsToBounds = NO;
  self.leftSwitchLabel.text = @"Notification";
  [self addSubview:self.leftSwitchLabel];
  
  //Left switch
  self.leftSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftSwitchLabel.frame),
                                                              CGRectGetHeight(self.bounds)-IMAGE_PADDING-32, 32, 32)];
  self.leftSwitch.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
  [self.leftSwitch addTarget:self action:@selector(onLeftSwitch:) forControlEvents:UIControlEventValueChanged];
  [self addSubview:self.leftSwitch];
   */
  
  //Right button
  self.rightButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
  self.rightButton.frame = CGRectMake(CGRectGetWidth(self.bounds)-IMAGE_PADDING-32,
                                      CGRectGetHeight(self.bounds)-IMAGE_PADDING-32, 32, 32);
  self.rightButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
  self.rightButton.showsTouchWhenHighlighted = YES;
  [self.rightButton addTarget:self action:@selector(onRightButton:) forControlEvents:UIControlEventTouchUpInside];
  [self addSubview:self.rightButton];
  
  //Performance optimization
  self.layer.shouldRasterize = YES;
  self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
  
  return self;
}


#pragma mark - Data

- (void)reset
{
  [super reset];
  
  self.titleLabel.text = @"";
  self.descriptionLabel.text = @"";
  self.descriptionLabel.frame = self.bounds;
}

- (void)configureWithModel:(SBDataModel*)theModel
{
  self.titleLabel.text = theModel.name;
  self.subtitleLabel.text = theModel.phone;
  self.descriptionLabel.text = theModel.message;
  self.imageView.image = [UIImage imageNamed:theModel.imageName];
  self.backgroundImageView.image = [self imageForType:theModel.type];
  self.leftSwitch.on = [theModel.onOff boolValue];
}

/*
 * Multi-color demo
 */
- (UIImage*)imageForType:(NSNumber*)type
{
  if (type == nil || [type integerValue] <= 1)
    return [UIImage imageNamed:@"stackbox_card"];
  
  NSString *imageName = [NSString stringWithFormat:@"stackbox_card_%@", type];
  return [UIImage imageNamed:imageName];
}


#pragma mark - Actions

- (IBAction)onLeftButton:(UIButton*)sender
{
  if ([self.delegate respondsToSelector:@selector(myContentView:onLeftButton:)])
    [self.delegate myContentView:self onLeftButton:self.leftButton];
}

- (IBAction)onRightButton:(UIButton*)sender
{
  if ([self.delegate respondsToSelector:@selector(myContentView:onRightButton:)])
    [self.delegate myContentView:self onRightButton:self.rightButton];
}

- (IBAction)onLeftSwitch:(UISwitch*)sender
{
  if ([self.delegate respondsToSelector:@selector(myContentView:onLeftSwitch:)])
    [self.delegate myContentView:self onLeftSwitch:self.leftSwitch];
}


#pragma mark - Layout

- (void)showSummaryMode:(CGFloat)duration newBounds:(CGRect)newBounds
{
  [super showSummaryMode:duration newBounds:newBounds];
  
  CGRect imageFrame = CGRectMake(IMAGE_PADDING, CGRectGetHeight(newBounds)-IMAGE_PADDING-IMAGE_SIZE,
                                 IMAGE_SIZE, IMAGE_SIZE);
  CGRect titleFrame = CGRectMake(CGRectGetMaxX(imageFrame)+TEXT_PADDING, CGRectGetMinY(imageFrame),
                                 CGRectGetWidth(newBounds) - CGRectGetMaxX(imageFrame) - IMAGE_PADDING - TEXT_PADDING,
                                 CGRectGetHeight(imageFrame)/2);
  CGRect subtitleFrame = CGRectMake(CGRectGetMinX(titleFrame), CGRectGetMaxY(titleFrame),
                                    CGRectGetWidth(titleFrame), CGRectGetHeight(imageFrame)/2);
  CGRect descriptionFrame = CGRectMake(IMAGE_PADDING, IMAGE_PADDING + TEXT_PADDING,
                                       CGRectGetWidth(newBounds) - 2*IMAGE_PADDING,
                                       CGRectGetMinY(imageFrame) - TEXT_PADDING - IMAGE_PADDING);
  descriptionFrame = [self getFrameToFitDescriptionLabel:descriptionFrame];
  
  [UIView animateWithDuration:duration delay:0
                      options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState
                   animations:^
   {
     self.imageView.frame = imageFrame;
     self.titleLabel.frame = titleFrame;
     self.subtitleLabel.frame = subtitleFrame;
     self.descriptionLabel.frame = descriptionFrame;
     self.leftButton.alpha = 0;
     self.rightButton.alpha = 0;
     self.leftSwitch.alpha = 0;
     self.leftSwitchLabel.alpha = 0;
     
   } completion:^(BOOL finished) {
     
     //Repeat everything for duration == 0
     self.imageView.frame = imageFrame;
     self.titleLabel.frame = titleFrame;
     self.subtitleLabel.frame = subtitleFrame;
     self.descriptionLabel.frame = descriptionFrame;
     self.leftButton.alpha = 0;
     self.rightButton.alpha = 0;
     self.leftSwitch.alpha = 0;
     self.leftSwitchLabel.alpha = 0;
     
   }];
}

- (void)showExtendedMode:(CGFloat)duration newBounds:(CGRect)newBounds
{
  [super showExtendedMode:duration newBounds:newBounds];
  
  CGRect imageFrame = CGRectMake(IMAGE_PADDING, IMAGE_PADDING, IMAGE_SIZE, IMAGE_SIZE);
  CGRect titleFrame = CGRectMake(CGRectGetMaxX(imageFrame)+TEXT_PADDING, CGRectGetMinY(imageFrame),
                                 CGRectGetWidth(newBounds) - CGRectGetMaxX(imageFrame) - IMAGE_PADDING - TEXT_PADDING,
                                 CGRectGetHeight(imageFrame)/2);
  CGRect subtitleFrame = CGRectMake(CGRectGetMinX(titleFrame), CGRectGetMaxY(titleFrame),
                                    CGRectGetWidth(titleFrame), CGRectGetHeight(imageFrame)/2);
  CGRect descriptionFrame = CGRectMake(IMAGE_PADDING, CGRectGetMaxY(imageFrame)+TEXT_PADDING,
                                       CGRectGetWidth(newBounds) - 2*IMAGE_PADDING,
                                       CGRectGetHeight(newBounds) - CGRectGetMaxY(imageFrame) - IMAGE_PADDING - TEXT_PADDING);
  descriptionFrame = [self getFrameToFitDescriptionLabel:descriptionFrame];
  
  [UIView animateWithDuration:duration delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = titleFrame;
    self.subtitleLabel.frame = subtitleFrame;
    self.descriptionLabel.frame = descriptionFrame;
    self.leftButton.alpha = 1;
    self.rightButton.alpha = 1;
    self.leftSwitch.alpha = 1;
    self.leftSwitchLabel.alpha = 1;
    
  } completion:^(BOOL finished) {
    
    //Repeat everything for duration == 0
    self.imageView.frame = imageFrame;
    self.titleLabel.frame = titleFrame;
    self.subtitleLabel.frame = subtitleFrame;
    self.descriptionLabel.frame = descriptionFrame;
    self.leftButton.alpha = 1;
    self.rightButton.alpha = 1;
    self.leftSwitch.alpha = 1;
    self.leftSwitchLabel.alpha = 1;
    
    //Allow the buttons to be interactive
    [[self superview] bringSubviewToFront:self];
    
  }];
}

- (CGRect)getFrameToFitDescriptionLabel:(CGRect)maxFrame
{
  CGSize size = [self.descriptionLabel.text sizeWithFont:self.descriptionLabel.font
                                       constrainedToSize:maxFrame.size
                                           lineBreakMode:self.descriptionLabel.lineBreakMode];
  maxFrame.size.height = size.height;
  return maxFrame;
}

@end
