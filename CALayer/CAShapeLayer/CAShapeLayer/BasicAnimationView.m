//
//  BasicAnimationView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/28.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "BasicAnimationView.h"

@interface BasicAnimationView ()<CAAnimationDelegate>
{
    CALayer *_layer;
}

@end

@implementation BasicAnimationView

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
        _layer.anchorPoint=CGPointMake(0.5, 0.6);//设置锚点
        _layer.contents=(id)[UIImage imageNamed:@"petal.png"].CGImage;
        [self.layer addSublayer:_layer];
    }
    return self;
}


#pragma mark 移动动画

-(void)translatonAnimation:(CGPoint)location{

    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.delegate = self;
    basicAnimation.toValue=[NSValue valueWithCGPoint:location];
    basicAnimation.duration = 5.0;
    basicAnimation.removedOnCompletion = NO;
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
    
}

#pragma mark 旋转动画  （图片选装）
-(void)rotationAnimation{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"]; // 这个旋转的过程的要注意
    
    //2.设置动画属性初始值、结束值
//    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI*3];
    //这里旋转管了 π*3
    
    //设置其他动画属性
    basicAnimation.duration=6.0;
    basicAnimation.autoreverses=true;//旋转后再旋转到原来的位置
    
    basicAnimation.repeatCount = HUGE_VALF ;
    basicAnimation.removedOnCompletion = NO;
    
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
    
}

#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self];
       CAAnimation *animation= [_layer animationForKey:@"KCBasicAnimation_Translation"];
    if(animation){
        if (_layer.speed==0) {
            [self animationResume];
        }else{
            [self animationPause];
        }
    }else{
        //创建并开始动画
        [self translatonAnimation:location];
        
        [self rotationAnimation];
    }
}


#pragma mark 动画暂停
-(void)animationPause{
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要 （就是自己的图层的时间大小）
    CFTimeInterval interval=[_layer convertTime:CACurrentMediaTime() fromLayer:nil]; //
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [_layer setTimeOffset:interval];
    // 媒体时间设置为从开始到现在的时间，速度为0 ，所以现在就停止的这状态
    
    //速度设置为0，暂停动画
    _layer.speed=0;
}

#pragma mark 动画恢复
-(void)animationResume{
    //获得暂停的时间
    CFTimeInterval beginTime= CACurrentMediaTime()- _layer.timeOffset; // 暂停的间隔的时间（这里的设置就是表示：前面暂停的时间过了暂停的间隔时间之后）
    //设置偏移量
    _layer.timeOffset=0;
    //设置开始时间
    _layer.beginTime=beginTime; 
    //设置动画速度，开始运动
    _layer.speed=1.0; // 速度设置为1
}

#pragma mark - 动画代理方法
#pragma mark 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
}

#pragma mark 动画结束

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    //开启事务
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    
    _layer.position=[[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    
    //提交事务
    [CATransaction commit];
    
    //暂停动画
    [self animationPause];
}

@end

/*
原理: 上面是两操作的组合，需要注意的是只给移动电话设置了了代理。（否则代理会执行两次）
 核心动画的运行有一个媒体时间的概念（媒体时间这个概念要清楚了解，如何进行使用）
 
 
 （1）媒体时间- 的时候用 （上一个好像就讲到了，媒体时间用子动画等等媒体时间上的处理）
 动画暂停针对的是图层而不是图层中的某个动画。
 要做无限循环的动画，动画的removedOnCompletion属性必须设置为NO，否则运行一次动画就会销毁。

 （2）属性的动画
 @interface CABasicAnimation : CAPropertyAnimation
 所以，首先了解一下CAPropertyAnimation 属性动画；（这些动画都是通过属性的设置的）
 + (instancetype)animationWithKeyPath:(nullable NSString *)path;  // 通过keypath来后去动画（也就是生成这个动画）
 @property(nullable, copy) NSString *keyPath;  //这些keyPath都是关键的字段的写法（并不是随便写的）它决定了是什么动画（也就是属性的意思）
 @property(getter=isAdditive) BOOL additive; // 动画的活动性（默认是no）
 也就是增加进去的属性，动过这个属性来激发新的属性动画展示出来。也就是在显示的动画中增加的新的属性，要显示出来，就可以通过对应的内容。
 @property(getter=isCumulative) BOOL cumulative; default is no, 这个属性影响了循环动画的产生，以及是否要冲抵诶动画的过程。
 @property(nullable, strong) CAValueFunction *valueFunction; 在动画显示前插入的值行为，（值行为是什么？）这个一个类，有待研究。
 
 PS:
 这个内容是关于动画的创建（获取的对应的内容，以及动画组合的重复活动性，循环的处理以及值行为）

 （3）基础动画 （进程属性动画）
 @property(nullable, strong) id fromValue;
 @property(nullable, strong) id toValue;
 @property(nullable, strong) id byValue;
 看到基础动画就是一个，有起点，过程点、终点。
 
 （4）其实这个东西不是很了解（应该就是用来查找对应的 x,y,x 它们之间的关系）
 @interface CAValueFunction : NSObject <NSCoding>
 + (nullable instancetype)functionWithName:(NSString *)name; // 这个怎么感觉就是我们常用来设置属性的那个keyPath？？
 @property(readonly) NSString *name;
 
 CA_EXTERN NSString * const kCAValueFunctionRotateX
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAValueFunctionRotateY
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAValueFunctionRotateZ
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
 CA_EXTERN NSString * const kCAValueFunctionScale
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
 CA_EXTERN NSString * const kCAValueFunctionScaleX
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAValueFunctionScaleY
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAValueFunctionScaleZ
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
 CA_EXTERN NSString * const kCAValueFunctionTranslate
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
 CA_EXTERN NSString * const kCAValueFunctionTranslateX
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAValueFunctionTranslateY
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAValueFunctionTranslateZ
 CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
 
 */
