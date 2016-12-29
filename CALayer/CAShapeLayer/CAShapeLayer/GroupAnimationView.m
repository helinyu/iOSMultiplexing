//
//  GroupAnimationView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/29.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "GroupAnimationView.h"

@interface GroupAnimationView ()<CAAnimationDelegate>
{
    CALayer *_layer;
}

@end

@implementation GroupAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置背景(注意这个图片其实在根图层)
        UIImage *backgroundImage=[UIImage imageNamed:@"background.jpg"];
        self.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
        
        //自定义一个图层
        _layer=[[CALayer alloc]init];
        _layer.bounds=CGRectMake(0, 0, 10, 20);
        _layer.position=CGPointMake(50, 150);
        _layer.contents=(id)[UIImage imageNamed:@"petal.png"].CGImage;
        [self.layer addSublayer:_layer];
        
        [self doGroupAnimation];
    }
    return self;
}

/// 动画组实现了旋转和曲线移动

- (void)doGroupAnimation {
    //(1) 创建动画组
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    // (2) 设置组中的动画和其他属性
    CABasicAnimation *basicAnimation=[self rotationAnimation];
    CAKeyframeAnimation *keyframeAnimation=[self translationAnimation];
    animationGroup.animations=@[basicAnimation,keyframeAnimation];
    animationGroup.delegate=self;
    animationGroup.duration=10.0;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
    animationGroup.beginTime=CACurrentMediaTime()+1;//延迟1秒执行
    
    //3.给图层添加动画
    [_layer addAnimation:animationGroup forKey:nil];
}

#pragma mark -- CAAnimationDelegate

#pragma mark - 代理方法
#pragma mark 动画完成
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CAAnimationGroup *animationGroup=(CAAnimationGroup *)anim;
    CABasicAnimation *basicAnimation = animationGroup.animations[0];
    CAKeyframeAnimation *keyframeAnimation = animationGroup.animations[1];
    CGFloat toValue=[[basicAnimation valueForKey:@"KCBasicAnimationProperty_ToValue"] floatValue];
    CGPoint endPoint=[[keyframeAnimation valueForKey:@"KCKeyframeAnimationProperty_EndPosition"] CGPointValue];
    
    /// 为什么这个就可以呢？停止
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    //设置动画最终状态
    _layer.position=endPoint;
    _layer.transform=CATransform3DMakeRotation(toValue, 0, 0, 1);
    
    [CATransaction commit];
}



#pragma mark 基础旋转动画
-(CABasicAnimation *)rotationAnimation{
    
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    CGFloat toValue=M_PI_2*3;
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
    
    //    basicAnimation.duration=6.0;
    basicAnimation.autoreverses=true;
    basicAnimation.repeatCount=HUGE_VALF;
    basicAnimation.removedOnCompletion=NO;
    
    [basicAnimation setValue:[NSNumber numberWithFloat:toValue] forKey:@"KCBasicAnimationProperty_ToValue"];
    
    return basicAnimation;
}

#pragma mark 关键帧移动动画
-(CAKeyframeAnimation *)translationAnimation{
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint endPoint= CGPointMake(55, 400);
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, endPoint.x, endPoint.y);
    
    keyframeAnimation.path=path;
    CGPathRelease(path);
    
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:endPoint] forKey:@"KCKeyframeAnimationProperty_EndPosition"];
    
    return keyframeAnimation;
}

@end

/*
基础的动画和关键动画在一个时间内，只有对于一个属性的动画，所以，有的时候的动画可能就是同一个时间需要对多个属性实现动画
动画组 主要是同时对多个属性进行控制（多动画控制），
 动画组是一系列的动画的组合，凡是添加到动画组中的动画都受控于动画组，这样各类动画公共的属性就可以统一设置替代一一设置。
 且放到动画组中的各个动画可以同时并发执行，构建更加复杂效果。
 
动画组使用的步骤：
 （1）创建单一的动画（可以是基础动画、关键帧动画）
 （2）将动画添加到动画组中
 （3）将动画组添加到图层
 
 @interface CAAnimationGroup : CAAnimation
 
 //@property(nullable, copy) NSArray<CAAnimation *> *animations; 添加动画组的属性
 
 CA 主要是关于动画
 CG 主要是关于绘画


*/
