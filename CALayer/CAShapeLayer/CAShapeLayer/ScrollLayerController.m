//
//  ScrollLayerController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/8.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "ScrollLayerController.h"
#import "ScrollView.h"

@interface ScrollLayerController ()

@end

@implementation ScrollLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    ScrollView *sonView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 64, 200, 200)];
    sonView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:sonView];
    
}

@end


/*
 (1)对于一个未转换的图层，它的bounds和它的frame是一样的，frame属性是由bounds属性自动计算而出的，所以更改任意一个值都会更新其他值
 在第二章中，我们探索了图层的contentsRect属性的用法，它的确是能够解决在图层中小地方显示大图片的解决方法。但是如果你的图层包含子图层那它就不是一个非常好的解决方案，因为，这样做的话每次你想『滑动』可视区域的时候，你就需要手工重新计算并更新所有的子图层位置。
ps: 这个时候就需要CAScrollLayer了
 
 Core Animation并不处理用户输入，所以CAScrollLayer并不负责将触摸事件转换为滑动事件，既不渲染滚动条，也不实现任何iOS指定行为例如滑动反弹（当视图滑动超多了它的边界的将会反弹回正确的地方）
 
&&&
UIScrollView并没有用CAScrollLayer
 
 改变移动的大小和位置
 - (void)scrollToPoint:(CGPoint)p;
 - (void)scrollToRect:(CGRect)r;

这个类应该是很少用的；

 
 
 
 */
