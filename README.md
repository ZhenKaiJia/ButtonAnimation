# ButtonAnimation


##效果图
![macdown Screenshot](/Users/Memebox/Desktop/ButtonAnimation.gif)

##使用
```
#import "DeformationButton.h"
```

##代码
```
DeformationButton *mationButton = [[DeformationButton alloc] initWithFrame:CGRectMake(100, 300, 140, 36) color:[UIColor redColor]];
    mationButton.radius = 3;
    [mationButton.displayButton setTitle:@"登录" forState:UIControlStateNormal];
    mationButton.clickAction = ^() {
        NSLog(@"点击登录");
    };
    [self.view addSubview:mationButton];
```