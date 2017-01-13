//
//  TransitionViewController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/12.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "TransitionViewController.h"

@interface TransitionViewController ()

@property (strong, nonatomic) UIView *layerView;
@property (strong, nonatomic) CALayer *colorLayer;
@property (strong, nonatomic) UIButton *btn;
@property (strong, nonatomic) UIButton *button ;

@end

@implementation TransitionViewController

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

    _button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 40, 40)];
    _button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_button];
    [_button addTarget:self action:@selector(changeTransationClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)changeColor
{
    NSLog(@"改变颜色");
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;                                                                                       
}


// 通过事务来修改隐式动画 通过显示动画修改
- (void)changeTransationClicked {
    
    //begin a new transaction
    [CATransaction begin];
    
    //set the animation duration to 1 second
    [CATransaction setAnimationDuration:3.0];
    
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    
    //commit the transaction
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

/*

 隐式动画（默认完成的动画，除非是禁止了隐式动画）
 
 
 Core Animation基于一个假设，说屏幕上的任何东西都可以（或者可能）做动画。动画并不需要你在Core Animation中手动打开，相反需要明确地关闭，否则他会一直存在。
 +
 当你改变CALayer的一个可做动画的属性，它并不能立刻在屏幕上体现出来。相反，它是从先前的值平滑过渡到新的值。这一切都是默认的行为，你不需要做额外的操作。(隐式动画)
 
 这其实就是所谓的隐式动画。之所以叫隐式是因为我们并没有指定任何动画的类型。我们仅仅改变了一个属性，然后Core Animation来决定如何并且何时去做动画。Core Animaiton同样支持显式动画，下章详细说明。
 但当你改变一个属性，Core Animation是如何判断动画类型和持续时间的呢？实际上动画执行的时间取决于当前”事务”的设置，动画类型取决于图层行为。
 
 事务实际上是Core Animation用来包含一系列属性动画集合的机制，任何用指定事务去改变可以做动画的图层属性都不会立刻发生变化，而是当事务一旦提交的时候开始用一个动画过渡到新值。
 
 事务是通过CATransaction类来做管理，这个类的设计有些奇怪，不像你从它的命名预期的那样去管理一个简单的事务，而是管理了一叠你不能访问的事务。CATransaction没有属性或者实例方法，并且也不能用+alloc和-init方法创建它。但是可以用+begin和+commit分别来入栈或者出栈。
 
 任何可以做动画的图层属性都会被添加到栈顶的事务，你可以通过+setAnimationDuration:方法设置当前事务的动画时间，或者通过+animationDuration方法来获取值（默认0.25秒）。
 
 Core Animation在每个run loop周期中自动开始一次新的事务（run loop是iOS负责收集用户输入，处理定时器或者网络事件并且重新绘制屏幕的东西），即使你不显式的用[CATransaction begin]开始一次事务，任何在一次run loop循环中属性的改变都会被集中起来，然后做一次0.25秒的动画。
 
 明白这些之后，我们就可以轻松修改变色动画的时间了。我们当然可以用当前事务的+setAnimationDuration:方法来修改动画时间，但在这里我们首先起一个新的事务，于是修改时间就不会有别的副作用。因为修改当前事务的时间可能会导致同一时刻别的动画（如屏幕旋转），所以最好还是在调整动画之前压入一个新的事务。
 
 如果你用过UIView的动画方法做过一些动画效果，那么应该对这个模式不陌生。UIView有两个方法，+beginAnimations:context:和+commitAnimations，和CATransaction的+begin和+commit方法类似。实际上在+beginAnimations:context:和+commitAnimations之间所有视图或者图层属性的改变而做的动画都是由于设置了CATransaction的原因。
 
 
 在iOS4中，苹果对UIView添加了一种基于block的动画方法：+animateWithDuration:animations:。这样写对做一堆的属性动画在语法上会更加简单，但实质上它们都是在做同样的事情。
 +
 CATransaction的+begin和+commit方法在+animateWithDuration:animations:内部自动调用，这样block中所有属性的改变都会被事务所包含。这样也可以避免开发者由于对+begin和+commit匹配的失误造成的风险。

*/
