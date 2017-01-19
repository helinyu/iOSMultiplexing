//
//  ExplicitAnimationViewController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/13.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "ExplicitAnimationViewController.h"

@interface ExplicitAnimationViewController ()

@end

@implementation ExplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:label];
    label.text = @"这个已经看过，可看博客园的文章";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

//上一章介绍了隐式动画的概念。隐式动画是在iOS平台创建动态用户界面的一种直接方式，也是UIKit动画机制的基础，不过它并不能涵盖所有的动画类型。在这一章中，我们将要研究一下显式动画，它能够对一些属性做指定的自定义动画，或者创建非线性动画，比如沿着任意一条曲线移动。
// 显示动画 ： 基础动画、关键帧动画、组动画 以及动画的过程的控制等等，这个已经看过，在博客园里面有关于这个文章
