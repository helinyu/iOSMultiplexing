//
//  EmitterLayerController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/8.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "EmitterLayerController.h"

@interface EmitterLayerController ()

@property (nonatomic, strong) UIView *containerView;


@end

@implementation EmitterLayerController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0,64,[[UIScreen mainScreen] bounds].size.width,200)];
    self.containerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.containerView];
    
    //create particle emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerUnordered;
    //渲染的模式的设置
    //    kCAEmitterLayerUnordered
    //    kCAEmitterLayerOldestFirst
    //    kCAEmitterLayerOldestLast
    //    kCAEmitterLayerBackToFront
    //    kCAEmitterLayerAdditive
    
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    
    emitter.emitterMode = kCAEmitterLayerSurface;
    //    kCAEmitterLayerPoints
    //    kCAEmitterLayerOutline
    //    kCAEmitterLayerSurface
    //    kCAEmitterLayerVolume
    
    emitter.emitterShape = kCAEmitterLayerCircle;
    //    kCAEmitterLayerPoint
    // kCAEmitterLayerLine
    // kCAEmitterLayerRectangle
    //     kCAEmitterLayerCuboid
    // kCAEmitterLayerCircle
    //    kCAEmitterLayerSphere
    
    //create a particle template
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"Spark.png"].CGImage;
    cell.birthRate = 10;
    cell.lifetime = 20.0;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    
    //add particle template to emitter
    emitter.emitterCells = @[cell];
}

@end

/*
 CAEmitterLayer是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果。
&&& 其实就是实现 就是实现瞬间爆炸的效果💥
 
 @property(nullable, copy) NSArray<CAEmitterCell *> *emitterCells;
在对应的layer上设置的cells的属性；
 
接下来的属性和爆炸的属性基本上是完全是一样的，所以这里的内容应该是没有问题的;
 
 CAEmitterCell
 CAEmitterLayer 实现发射的效果
 
 一个CAEmitterCell类似于一个CALayer
 它有一个contents属性可以定义为一个CGImage，另外还有一些可设置属性控制着表现和行为。
 
 
 CAEMitterCell的属性基本上可以分为三种：
 * 这种粒子的某一属性的初始值。
 * 例子某一属性的变化范围。
 * 指定值在时间线上的变化。
 z这些属性会以相乘的方式作用在一起的；
 
 */
