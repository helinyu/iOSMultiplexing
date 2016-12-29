
//
//  KeyFrameAnimationView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/28.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "KeyFrameAnimationView.h"

@interface KeyFrameAnimationView()
{
    CALayer *_layer;
}

@end

@implementation KeyFrameAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
        
        // 自定义图层
        _layer = [CALayer layer];
        _layer.bounds = CGRectMake(0, 0, 10, 20);
        _layer.position = CGPointMake(50, 150);
        _layer.contents = (id)[UIImage imageNamed:@"petal.png"].CGImage;
        [self.layer addSublayer:_layer];
        
        // 创建动画
        [self translationAnimation];
        [self translationForBezith];
    }
    return self;
}

#pragma mark -- 关键 帧动画
// part 1  设置不同的属性值进行关键帧控制
// 这个是通过属性的变化来处理了对应的路径的内容（两点之间是执行的过度）
- (void)translationAnimation {

    // 1 创建关键帧并设置动画属性
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *key1 = [NSValue valueWithCGPoint:_layer.position];//关键帧初始值不可以省略
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3=[NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4=[NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSArray *values=@[key1,key2,key3,key4];// 这几个key就是关键帧
    keyFrameAnimation.values = values;
    
    // 2   设置其他属性
    keyFrameAnimation.duration = 8.0;
    keyFrameAnimation.beginTime = CACurrentMediaTime() + 2; // 延迟2秒执行
    
    // 3  添加动画到图层、添加动画后会执行动画
    [_layer addAnimation:keyFrameAnimation forKey:@"KCKeyframeAnimation_Positionr"];
    
}

// part 2 通过描绘路径进行关键帧动画控制 (花落沿着曲线（贝塞尔曲线）)

- (void)translationForBezith {
    CAKeyframeAnimation *keyFrameAnimaiton = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 设置路径(CG的图形的绘画，这个先不管了)
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y); // 移动到起点
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);// 绘制二次贝塞尔曲线
    keyFrameAnimaiton.path = path;
    CGPathRelease(path);
    
    // 设置其他属性
    keyFrameAnimaiton.duration = 8.0;
    keyFrameAnimaiton.beginTime = CACurrentMediaTime() + 5;
    
    //3.添加动画到图层，添加动画后就会执行动画
    [_layer addAnimation:keyFrameAnimaiton forKey:@"KCKeyframeAnimation_Position"];
    
}

@end

/*
 (1)关键帧动画；
 flash 中有这个概念，就是处理主要的几个关键帧，中间的帧都是过度的帧（是由系统自动补充，所以两个帧之间形成了补帧动画）。
 关键帧开发分为两种形式：
 （1）通过设置不同的属性值来进行关键帧控制
 （2）通过设置路径
 
 关键帧动画的一些属性；
 @interface CAKeyframeAnimation : CAPropertyAnimation
 @property(nullable, copy) NSArray *values; // 这里存储属性值数组
 @property(nullable) CGPathRef path;  // 这里存储了路径
 @property(nullable, copy) NSArray<NSNumber *> *keyTimes; 
 //各个关键帧的时间控制（0-1）（前面8/(4-1)秒，若是要控制每一帧而不是平均每一帧的时间，也就是时间占用的比例，此时可以设置keyTimes的值为0.0，0.5，0.75，1.0，就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束）
 @property(nullable, copy) NSArray<CAMediaTimingFunction *> *timingFunctions; // 时间行为（通过时间而改变的一种行为）
 defines n keyframes, there should be n-1 objects in the timingFunctions' array（定义了从这一-帧到另外一帧的时间）
 @property(copy) NSString *calculationMode;  、//动画计算模式
 上面keyValues动画举例，之所以1到2帧能形成连贯性动画而不是直接从第1帧经过8/3秒到第2帧是因为动画模式是连续的（值为kCAAnimationLinear，这是计算模式的默认值）
 如果指定了动画模式为kCAAnimationDiscrete离散的那么你会看到动画从第1帧经过8/3秒直接到第2帧，中间没有任何过渡。
 动画模式还有：kCAAnimationPaced（均匀执行，会忽略keyTimes）、kCAAnimationCubic（平滑执行，对于位置变动关键帧动画运行轨迹更平滑）、kCAAnimationCubicPaced（平滑均匀执行）
 `discrete', `linear', `paced', `cubic' and `cubicPaced'. 可以有这些属性；
 默人是linear，如果设置了paced' or `cubicPaced' the `keyTimes' and `timingFunctions' 这些属性，动画就会忽略；
 
 @property(nullable, copy) NSArray<NSNumber *> *tensionValues;
 @property(nullable, copy) NSArray<NSNumber *> *continuityValues;
 @property(nullable, copy) NSArray<NSNumber *> *biasValues;
 @property(nullable, copy) NSString *rotationMode;
 
 `calculationMode' strings.
 
 CA_EXTERN NSString * const kCAAnimationLinear
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAAnimationDiscrete
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAAnimationPaced
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAAnimationCubic
 CA_AVAILABLE_STARTING (10.7, 4.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAAnimationCubicPaced
 CA_AVAILABLE_STARTING (10.7, 4.0, 9.0, 2.0);
 
 `rotationMode' strings.
 
 CA_EXTERN NSString * const kCAAnimationRotateAuto
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAAnimationRotateAutoReverse
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 
 
 
 */
