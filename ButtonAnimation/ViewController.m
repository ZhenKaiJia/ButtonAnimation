//
//  ViewController.m
//  ButtonAnimation
//
//  Created by Justin on 16/11/7.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "ViewController.h"
#import "DeformationButton.h"

@interface ViewController ()

@property (nonatomic, strong) DeformationButton *mationButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createButton];
}

- (void)createButton {
    self.mationButton = [[DeformationButton alloc] initWithFrame:CGRectMake(100, 300, 140, 36) color:[UIColor redColor]];
    self.mationButton.radius = 3;
    [self.mationButton.displayButton setTitle:@"登录" forState:UIControlStateNormal];
    self.mationButton.clickAction = ^() {
        NSLog(@"点击登录");
    };
    [self.view addSubview:self.mationButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
