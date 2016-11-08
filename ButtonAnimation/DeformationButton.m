//
//  DeformationButton.m
//  ButtonAnimation
//
//  Created by Justin on 16/11/8.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "DeformationButton.h"
#import "AnimationMeterial.h"

@interface DeformationButton ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, strong) AnimationMeterial *spinnerView;

@end

@implementation DeformationButton{
    CGFloat defaultW;
    CGFloat defaultH;
    CGFloat defaultR;
    CGFloat scale;
    UIColor *initialColor;
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        initialColor = color;
        [self initSettingWithColor:color];
    }
    return self;
}

- (void)initSettingWithColor:(UIColor *)color {
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;

    scale = 1.0;
    
    self.bgView = [[UIView alloc] initWithFrame:self.bounds];
    self.bgView.backgroundColor = color;
    self.bgView.userInteractionEnabled = NO;
    
    self.bgView.hidden = YES;
    self.bgView.layer.masksToBounds = NO;
    [self addSubview:self.bgView];
    
    defaultH = self.bgView.frame.size.height;
    defaultW = self.bgView.frame.size.width;
    defaultR = self.bgView.layer.cornerRadius;
    
    self.spinnerView = [[AnimationMeterial alloc]initWithFrame:CGRectZero];
    self.spinnerView.bounds = CGRectMake(0, 0, defaultW*0.75, defaultH*0.75);
    self.spinnerView.lineWidth = 2;
    self.spinnerView.tintColor = [UIColor whiteColor];
    self.spinnerView.center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
    self.spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.spinnerView.userInteractionEnabled = NO;
    [self addSubview:self.spinnerView];
    
    [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.displayButton = [[UIButton alloc]initWithFrame:self.bounds];
    self.displayButton.userInteractionEnabled = NO;
    [self addSubview:self.displayButton];
}

- (void)buttonClick {
    if (self.isLoding) {
        [self stopLoding];
    }else {
        [self startLoding];
        if (self.clickAction) {
            self.clickAction();
        }
    }
}

- (void)startLoding {
    if (self.backgroundImage == nil) {
        self.backgroundImage = [self.displayButton backgroundImageForState:UIControlStateNormal];
    }
    self.bgView.hidden = NO;
    
    _isLoding = YES;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:defaultR];
    animation.toValue = [NSNumber numberWithFloat:defaultH*scale*0.5];
    animation.duration = 0.3;
    [self.bgView.layer setCornerRadius:defaultH*scale*0.5];
    [self.bgView.layer addAnimation:animation forKey:@"cornerRadius"];
    
    [self.displayButton setBackgroundImage:nil forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6  initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale, defaultH*scale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6  initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.bgView.layer.bounds = CGRectMake(0, 0, defaultH*scale, defaultH*scale);
            self.displayButton.transform = CGAffineTransformMakeScale(0, 0);
            self.displayButton.hidden = YES;
        } completion:^(BOOL finished) {
            if (_isLoding) {
                self.displayButton.hidden = YES;
                [self.spinnerView startAnimation];
            }
        }];
    }];
}

- (void)stopLoding {
    [self.spinnerView stopAnimation];
    self.displayButton.hidden = NO;
    
    _isLoding = NO;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:
     UIViewAnimationOptionCurveLinear animations:^{
         self.displayButton.transform = CGAffineTransformMakeScale(1, 1);
         self.displayButton.alpha = 1;
     } completion:^(BOOL finished) {
     }];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = [NSNumber numberWithFloat:defaultH*scale*0.5];
    animation.toValue = [NSNumber numberWithFloat:defaultR];
    animation.duration = 0.3;
    [self.bgView.layer setCornerRadius:defaultH*scale*0.5];
    [self.bgView.layer addAnimation:animation forKey:@"cornerRadius"];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.bgView.layer.bounds = CGRectMake(0, 0, defaultW*scale, defaultH*scale);
    } completion:^(BOOL finished) {
        if (!_isLoding) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
            animation.timingFunction = [CAMediaTimingFunction     functionWithName:kCAMediaTimingFunctionLinear];
            animation.fromValue = [NSNumber numberWithFloat:self.bgView.layer.cornerRadius];
            animation.toValue = [NSNumber numberWithFloat:defaultR];
            animation.duration = 0.3;
            [self.bgView.layer setCornerRadius:defaultR];
            [self.bgView.layer addAnimation:animation forKey:@"cornerRadius"];
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.bgView.layer.bounds = CGRectMake(0, 0, defaultW, defaultH);
            } completion:^(BOOL finished) {
                if (!_isLoding) {
                    if (self.backgroundImage != nil) {
                        [self.displayButton setBackgroundImage:self.backgroundImage forState:UIControlStateNormal];
                    }
                    self.bgView.hidden = YES;
                }
            }];
        }
    }];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    defaultR = radius;
    self.bgView.layer.cornerRadius = defaultR;
    [self.displayButton setBackgroundImage:[[self imageWithColor:initialColor cornerRadius:defaultR] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)] forState:UIControlStateNormal];
}

- (void)setIsLoding:(BOOL)isLoding {
    _isLoding = isLoding;
    if (_isLoding) {
        [self stopLoding];
    }else {
        [self startLoding];
    }
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self.displayButton setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self.displayButton setHighlighted:highlighted];
}

- (UIImage*)imageWithColor:(UIColor*)color cornerRadius:(CGFloat)cornerRadius{
    CGRect rect = CGRectMake(0, 0, cornerRadius*2+10, cornerRadius*2+10);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    path.lineWidth = 0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    [path fill];
    [path stroke];
    [path addClip];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
