//
//  BasicAnimationView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "BasicAnimationView.h"

@interface BasicAnimationView ()<CAAnimationDelegate>
{
    CALayer *_layer;
    CALayer *_stretchLayer;
}

@end

@implementation BasicAnimationView

// 下面是一个平移的动作

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景(注意这个图片其实在根图层)
//        UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
//        self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        self.backgroundColor = [UIColor grayColor];
        
        //自定义一个图层 用于平移
        _layer=[[CALayer alloc]init];
        _layer.bounds=CGRectMake(0, 0, 10, 20);
        _layer.position=CGPointMake(50, 150);
        _layer.contents=(id)[UIImage imageNamed:@"petal.png"].CGImage;
        [self.layer addSublayer:_layer];
        
        //自定义一个图层用于拉伸
        _stretchLayer = [CALayer layer];
        _stretchLayer.backgroundColor = [UIColor greenColor].CGColor;
        
    }
    return self;
}

#pragma mark 移动动画
-(void)translatonAnimation:(CGPoint)location{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.delegate = self;
    //2.设置动画属性初始值和结束值
//        basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
    basicAnimation.toValue=[NSValue valueWithCGPoint:location];
    
    //设置其他动画属性
    basicAnimation.duration = 3.0;// animaiton duration
//    basicAnimation.repeatCount = NSNotFound;//default，只是会移动一次 is 0//HUGE_VALF; //设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果,(当然，这个字段可以使用其他的字段)
    basicAnimation.removedOnCompletion = NO;//运行一次是否移除动画 default is true (好像加上去没有神峨眉区别)[在渲染树上完全去掉]
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"]; //(la1) layer 添加animation
    
}

// 修改上面移动之后的图片又回到了原来的地方的错误
-(void)translatonAnimationChanged:(CGPoint)location{
 
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.delegate = self;
    //2.设置动画属性初始值和结束值
    basicAnimation.fromValue=[NSValue valueWithCGPoint:CGPointMake(50, 150)];//可以不设置，默认为图层初始状态
    basicAnimation.toValue=[NSValue valueWithCGPoint:location];
    
    //设置其他动画属性
    basicAnimation.duration = 3.0;// animaiton duration
    //    basicAnimation.repeatCount = NSNotFound;//default，只是会移动一次 is 0//HUGE_VALF; //设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果,(当然，这个字段可以使用其他的字段)
//    basicAnimation.removedOnCompletion = NO;//运行一次是否移除动画 default is true (好像加上去没有神峨眉区别)[在渲染树上完全去掉]
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"]; //(la1) layer 添加animation
    
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];


}

- (void)stretchLayer {
    CABasicAnimation *stretchAnimaiton = [CABasicAnimation animationWithKeyPath:@"stretch"];
    stretchAnimaiton.fromValue = @(50);
    stretchAnimaiton.toValue = @(300);
    stretchAnimaiton.duration = 10.0f;
    [_layer addAnimation:stretchAnimaiton forKey:@"stretchLyaer"];
}

#pragma mark -- CAAniatiom attributes

- (void)testAnimaitonAttributes {
    CAAnimation *anima = [CAAnimation animation]; // use less  Creates a new animation object.
    
    /* Animations implement the same property model as defined by CALayer.
                                                        * See CALayer.h for more details. */
//    + (nullable id)defaultValueForKey:(NSString *)key; // CALayer中也有这个方法的获取，通过key获取默认的id（这里可以转化为animation，也可以是layer）：也就是id表示的元婴
    CALayer *layer = [CAAnimation defaultValueForKey:@"position"];
//    - (BOOL)shouldArchiveValueForKey:(NSString *)key; //
    
    CAMediaTimingFunction *mediaTimingFunction = anima.timingFunction; // 这个属性可以查看对应的时间的对应的快慢以及时间的关系
    anima.delegate = self ;
    
//    anima.removedOnCompletion = true; // 在界面渲染树上进行动画结束之后是否删除
//    animationDidStart 动画开始
//    animationDidStop 动画结束
    
    CAMediaTimingFunction *timeFouction = [CAMediaTimingFunction functionWithName:@"timeFunction"];
    NSLog(@"time function is ; %@",timeFouction);
}
#pragma mark -- did start

- (void)animationDidStart:(CAAnimation *)anim {
    NSArray *animationkeys = _layer.animationKeys ; //(la2)
    NSLog(@"animationkeys count is ： %lu",(unsigned long)animationkeys.count); // 这里可以看到添加到的animationkey
    
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
    
   
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

//    NSArray *animationkeys = _layer.animationKeys ;
//    NSLog(@"animationkeys count is ： %lu",(unsigned long)animationkeys.count);
////     basicAnimation.removedOnCompletion = NO 这个属性影响了运行完之后是否还存在
//    
//    CAAnimation *getAnimation = [_layer animationForKey:@"KCBasicAnimation_Translation"]; // （la3）通过key来获取对应的animation
//
//    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
//     重新设置移动块的位置 （解决默认平移之后又回到起点的问题）
//    _layer.position= [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue]; //这个方法没有获取到
    
//    CABasicAnimation *baseAnimation = (CABasicAnimation *)anim;
//    _layer.position = [baseAnimation.toValue CGPointValue]; // 通过这个方法来重新设置了对应的停止的位置（问题：就是冲起点到终点的滑动）？？？？？
    //开启事务
//    
    CABasicAnimation *baseAnimation = (CABasicAnimation *)anim;
    //    CABasicAnimation *baseAnimation = (CABasicAnimation *)anim; // 这句话应该放到外面，避免这个关闭隐式调用时间过长
    
    [CATransaction begin];
    [CATransaction disableActions];
    _layer.position = [baseAnimation.toValue CGPointValue];
    [CATransaction commit];
    //这个方法并没有起到作用？为什么？
    
    
    /* Accessors for the "disableActions" per-thread transaction property.
     * Defines whether or not the layer's -actionForKey: method is used to
     * find an action (aka. implicit animation) for each layer property
     * change. Defaults to NO, i.e. implicit animations enabled. */
//    + (BOOL)disableActions;
//    + (void)setDisableActions:(BOOL)flag;

}

@end
/*
 三个基本比步骤
 1、基础动画： 就是创建一个基础动画（通过唯一给keyPath标示符来生成一个基础动画）
 2、一定要设置动画的-起始和结束的值 或者路径
 2~3 ： 这个之间可以自定义设置其他的属性
 3、给layer添加动画 （layer可能也会添加很多个动画，所以也会有key值）
 
 &&
 (la1:表示使用layer 和animaiton 关系的第一个)
 
 ???
 (1) translatonAnimation 平移的方法处理之后出现了平移了之后又会回到原来起始的位置，怎么破????
 前面说过图层动画的本质就是将图层内部的内容转化为位图经硬件操作形成一种动画效果，其实图层本身并没有任何的变化.上面的动画中图层并没有因为动画效果而改变它的位置（对于缩放动画其大小也是不会改变的）所以动画完成之后图层还是在原来的显示位置没有任何变化，如果这个图层在一个UIView中你会发现在UIView移动过程中你要触发UIView的点击事件也只能点击原来的位置（即使它已经运动到了别的位置），因为它的位置从来没有变过。
 ps: UIview的内容还是没有变化的，也即是移动是一个动态显示的一种效果（过程量，原本的相应的内容没有改变，位图经过硬件操作而显示的一种的效果）
 怎么破？
 ps： 绘画完了之后，在其末尾的位置重新设置位置 
???
 产生问题？
 就是出现了点从起点滑动到终点的过程
 这个问题产生的原因就是前面提到的，对于非根图层，设置图层的可动画属性（在动画结束后重新设置了position，而position是可动画属性）会产生动画效果
 （根图层： 就是UIView 上面的的第一个图层layer）
 ps：两种方法（1）关闭图层隐式动画、（2）设置动画图层为根图层。显然这里不能采取后者，因为根图层当前已经作为动画的背景。 （这个过程应该在停止的时候就要开启关闭隐式动画）
不过，上面的隐式处理好像并没有关闭动画效果
 
 &&&&&
CATransaction 就是一个事务：（控制动画的动画过程中的显示动画还是隐式动画的控制）
 这个对应的commit的内容是和run loop 有关的
 有关和兴的关键字
CA_EXTERN NSString * const kCATransactionAnimationDuration // 事务的动画时间
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCATransactionDisableActions // 不能够运行
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCATransactionAnimationTimingFunction // 时间动画的函数
CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);
CA_EXTERN NSString * const kCATransactionCompletionBlock // 一个block
CA_AVAILABLE_STARTING (10.6, 4.0, 9.0, 2.0);

+ (void)begin; 创建一个新的事务

+ (void)commit; 提交事务

+ (void)flush; // 去掉？？？

// 在多线程中需要进行处理这个国车用
+ (void)lock;
+ (void)unlock;
#&&&&&
 
 
  */

