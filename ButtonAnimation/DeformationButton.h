//
//  DeformationButton.h
//  ButtonAnimation
//
//  Created by Justin on 16/11/8.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeformationButton : UIButton

@property (nonatomic, assign) BOOL isLoding;

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) UIButton *displayButton;

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;

@property (nonatomic, copy) void(^clickAction)();

@end
