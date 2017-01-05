//
//  GradientLayerController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/5.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "GradientLayerController.h"

@interface GradientLayerController ()

@property (strong, nonatomic) UIView *containerView;

@property (strong, nonatomic) UIView *containerView2;


@end

@implementation GradientLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0,64,[[UIScreen mainScreen] bounds].size.width,200)];
    [self.view addSubview:self.containerView];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.containerView2= [[UIView alloc] initWithFrame:CGRectMake(0,300,[[UIScreen mainScreen] bounds].size.width,200)];
    [self.view addSubview:self.containerView2];
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame = self.containerView2.bounds;
    [self.containerView2.layer addSublayer:gradientLayer2];
    
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    // 取值范围是从(0,0) 到（1，1）
    
    
//    默认是均匀分布的，这里就是可以通过location来区分不同的分布
    gradientLayer2.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    gradientLayer2.locations = @[@0.1, @0.35, @0.6];
//    /set gradient start and end points
    gradientLayer2.startPoint = CGPointMake(0, 0);
    gradientLayer2.endPoint = CGPointMake(1, 1);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


/*
CAGradientLayer是用来生成两种或更多颜色平滑渐变的。用Core Graphics复制一个CAGradientLayer并将内容绘制到一个普通图层的寄宿图也是有可能的，
  &&&& (重点) 但是CAGradientLayer的真正好处在于绘制使用了硬件加速。
 
 实例：简单的红变蓝的对角线渐变开始
 .这些渐变色彩放在一个数组中，并赋给colors属性。这个数组成员接受CGColorRef类型的值（并不是从NSObject派生而来），所以我们要用通过bridge转换以确保编译正常。
 
 // 默认
 这些颜色在空间上均匀地被渲染，但是我们可以用locations属性来调整空间
 
 @property(copy) NSString *type;
是什类型，默认是 axial（现在也是只有一个值而已嘛
 CA_EXTERN NSString * const kCAGradientLayerAxial CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
@property(nullable, copy) NSArray *colors;
@property(nullable, copy) NSArray<NSNumber *> *locations;
@property CGPoint startPoint;
@property CGPoint endPoint;


 
*/
