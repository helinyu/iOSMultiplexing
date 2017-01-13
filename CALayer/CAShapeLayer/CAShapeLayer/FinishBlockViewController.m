//
//  FinishBlockViewController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/12.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "FinishBlockViewController.h"

@interface FinishBlockViewController ()

@property (strong, nonatomic) UIView *layerView;
@property (strong, nonatomic) CALayer *colorLayer;
@property (strong, nonatomic) UIButton *btn;

@end

@implementation FinishBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"事务";
    
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), 200)];
    [self.view addSubview:self.layerView];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
    
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 40, 40)];
    _btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_btn];
    [_btn addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeColor {
    
    //begin a new transaction
    [CATransaction begin];
    
    //set the animation duration to 1 second
    [CATransaction setAnimationDuration:1.0];
    
    // block的方式进行调用
    //add the spin animation on completion
    [CATransaction setCompletionBlock:^{
        //rotate the layer 90 degrees
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    //commit the transaction
    [CATransaction commit];
    
    // 注意旋转动画要比颜色渐变快得多，这是因为完成块是在颜色渐变的事务提交并出栈之后才被执行，于是，用默认的事务做变换，默认的时间也就变成了0.25秒。
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
