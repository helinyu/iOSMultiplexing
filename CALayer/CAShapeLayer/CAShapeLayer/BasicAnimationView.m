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
//    basicAnimation setValue:kCAMediaTimingFunctionEaseInEaseOut forKey:<#(nonnull NSString *)#>
    [basicAnimation.timingFunction setValue:kCAMediaTimingFunctionEaseOut forKeyPath:@"position"];
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
 
 &&&&
 (la1:表示使用layer 和animaiton 关系的第一个)
 
 (1)&&&&&
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
 CATransaction 是coreAnimation上的一个机制，用于配置 多个layer图层的操作进入原子更新头渲染树种。每一个对layer tree的修改都要求事务成为其中的一部分。
 
 coreAnimation有两种类型，一种是显示（明确） 一种隐式的（蕴含的）
 显示的是：通过 [CATransaction begin]方法调用的开始，在layer tree修改之前，[CATransaction commit] 这里结束。
 
 而隐式的则会自动在core animation 中自动创建，。layer tree修改的时候不会通过一个线程启动transation，他们会自动添加到run loop 线程中，他们自动提交当线程run loop 到下一个block中。这个也许需要使用精确的失误去
 
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
 
 //block 类型
 #if __BLOCKS__
 + (nullable void (^)(void))completionBlock;
 + (void)setCompletionBlock:(nullable void (^)(void))block;
 #endif
 
 + (nullable id)valueForKey:(NSString *)key;
 + (void)setValue:(nullable id)anObject forKey:(NSString *)key;
 
 "animationDuration", "animationTimingFunction", "completionBlock",
 * "disableActions".
 
 PS:(总结)
 为什么这个还是不行呢？
 因为动画已经执行完了，就会返回到上面的那个点，所以，要设置这个点，这个时候也会调到最后的位置，也是有问题的
#&&&&&
 
(2)&&&& 控制时间段动画
 CAMediaTimingFunction  (可以翻译为： 媒体时间段行为)
 NSKeyValueCoding kvc的接口访问 （KVC的具体内容）

 这里使用媒体汗水类来进行管理
 Timing function names.
CA_EXTERN NSString * const kCAMediaTimingFunctionLinear  //线性
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseIn   //  开始的时候缓慢
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOut  // 结束的时候缓慢
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInEaseOut  // 开始和结束的回收偶读缓慢
CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
CA_EXTERN NSString * const kCAMediaTimingFunctionDefault   // 默认的
CA_AVAILABLE_STARTING (10.6, 3.0, 9.0, 2.0);

 这个应该是一个相关的内容，也就是时间上的行额能力；
 + (instancetype):(NSString *)name;
 创建这样的一个对象，也就是如何进行创建对象
 
  Creates a timing function modelled on a cubic Bezier curve. The end
 * points of the curve are at (0,0) and (1,1), the two points 'c1' and
 * 'c2' defined by the class instance are the control points. Thus the
 * points defining the Bezier curve are: '[(0,0), c1, c2, (1,1)]'
+ (instancetype)functionWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
- (instancetype)initWithControlPoints:(float)c1x :(float)c1y :(float)c2x :(float)c2y;
这个方法就可以定义两个不同阶段的时间段的行为
这里就是从c1到c2的动作。

'idx' is a value from 0 to 3 inclusive.
- (void)getControlPointAtIndex:(size_t)idx values:(float[2])ptr;

这里还会涉及都value和point之间的数据结构的转化； 这个同样会涉及到CI或者UI的内容;(这个不是重点)

(3) CAAnimation的动画的 父类
 CAAnimationDelegate
  - (void)animationDidStart:(CAAnimation *)anim;
 动画的开始就会调用
 - (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
 动画结束会调用

 CAAnimation 是一个抽象类，可以创建，protocol才不可以创建，不过创建了需要进行定义了一些对应的内容，一般都是不用自定义创建，一般是写子类来进程这个类，我们就可以使用这个类的方法
testAnimaitonAttributes 上面的这个方法就写了有关属性的测试
 基本上就是打通了：mediaTimingFunction / layer （以及transaction） 的关系；
 
 （4）CALayer 图层Layer子类
 
*/

