//
//  SpringAnimationView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/29.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "SpringAnimationView.h"

@interface SpringAnimationView ()
{
    CALayer *_layer;
}

@end

@implementation SpringAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
        
        // 自定义图层
        _layer = [CALayer layer];
        _layer.bounds = CGRectMake(0, 0, 10, 200);
        _layer.position = CGPointMake(50, 150);
        _layer.contents = (id)[UIImage imageNamed:@"petal.png"].CGImage;
        [self.layer addSublayer:_layer];
        
        // 创建动画
        [self springAnimation];
        
    }
    return self;
}

// 实现了一个压缩弹簧的记过，这个keyPath如果进行设置的？这里面应该是关键字
- (void)springAnimation {
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
    springAnimation.fromValue = @1;
    springAnimation.toValue = @0.5;
    springAnimation.duration = 10.0f;
    [_layer addAnimation:springAnimation forKey:@"spring_transformscale"];
    NSLog(@"springAnimation is : %f",springAnimation.settlingDuration);
}

@end

/*
  ==== 好像view上也有对应的动画 UIViewAnimationWithBlocks 这个分类里面是view的动画，应该是苹果内部的封装
  ==== 弹簧的效果可以到view上去查看，进行设置；
 
//弹簧动画，继承了基础动画
 @interface CASpringAnimation : CABasicAnimation
 //继承了基础动画
 
 @property CGFloat mass;
 //聚合能力，默认是1 ，必须大于1
 
 @property CGFloat stiffness;
 // 硬度 ，硬度系数。默认是100，必须大于0
 
 @property CGFloat damping;
 // 阻尼 系数，必须大于0 ，默认是10
 
 @property CGFloat initialVelocity;
 // 初始速度 ，默认是0
 
 @property(readonly) CFTimeInterval settlingDuration;
 //沉淀时间，只读，估计的当前动画的时间。
 
 @end
 
 animationWithKeyPath的值： 这就是这里的属性就是可以填写layer的所有属性
 *** 这就是这个值你需要到CALayer中去查找；去calayer中找一下就好
 
 transform.scale = 比例轉換
 
 transform.scale.x = 闊的比例轉換
 
 transform.scale.y = 高的比例轉換
 
 transform.rotation.z = 平面圖的旋轉
 
 opacity = 透明度
 
 margin
 
 zPosition
 
 backgroundColor    背景颜色
 
 cornerRadius    圆角
 
 borderWidth
 
 bounds
 
 contents
 
 contentsRect
 
 cornerRadius
 
 frame
 
 hidden
 
 mask
 
 masksToBounds
 
 opacity
 
 position
 
 shadowColor
 
 shadowOffset
 
 shadowOpacity
 
 shadowRadius
 
 keyPath 可以设置这些值；
 
 （2）UIView上面的弹簧的内容
 ///uiview 上面的弹簧的方法
 + (void)animateWithDuration:(NSTimeInterval)duration
 delay:(NSTimeInterval)delay
 usingSpringWithDamping:(CGFloat)dampingRatio
 initialSpringVelocity:(CGFloat)velocity
 options:(UIViewAnimationOptions)options
 animations:(void (^)(void))animations
 completion:(void (^)(BOOL finished))completion

 这里是会关于UIView上面的弹簧动画的参考链接
 https://www.renfei.org/blog/ios-8-spring-animation.html
 http://www.devtalking.com/articles/uiview-spring-animation/
 http://www.csdn.net/article/2015-07-03/2825122-ios-uiview-animation-2
 
 (3)UIView 上关于动画的分类 也即是这些动画不是在自图层上进行自定义，我们都是可以在UIView上直接使用UIView的方法实现动画，（这里的-动画效果就是根图层了）
 @interface UIView(UIViewAnimation)
 
 + (void)beginAnimations:(nullable NSString *)animationID context:(nullable void *)context;  // additional context info passed to will start/did stop selectors. begin/commit can be nested
 + (void)commitAnimations;                                                 // starts up any animations when the top level animation is commited
 
 // no getters. if called outside animation block, these setters have no effect.
 + (void)setAnimationDelegate:(nullable id)delegate;                          // default = nil
 + (void)setAnimationWillStartSelector:(nullable SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
 + (void)setAnimationDidStopSelector:(nullable SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
 + (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
 + (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
 + (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
 + (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
 + (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
 + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;    // default = NO. used if repeat count is non-zero
 + (void)setAnimationBeginsFromCurrentState:(BOOL)fromCurrentState;  // default = NO. If YES, the current view position is always used for new animations -- allowing animations to "pile up" on each other. Otherwise, the last end state is used for the animation (the default).
 
 + (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache;  // current limitation - only one per begin/commit block
 
 + (void)setAnimationsEnabled:(BOOL)enabled;                         // ignore any attribute changes while set.
 #if UIKIT_DEFINE_AS_PROPERTIES
 @property(class, nonatomic, readonly) BOOL areAnimationsEnabled;
 #else
 + (BOOL)areAnimationsEnabled;
 #endif
 + (void)performWithoutAnimation:(void (NS_NOESCAPE ^)(void))actionsWithoutAnimation NS_AVAILABLE_IOS(7_0);
 
 #if UIKIT_DEFINE_AS_PROPERTIES
 @property(class, nonatomic, readonly) NSTimeInterval inheritedAnimationDuration NS_AVAILABLE_IOS(9_0);
 #else
 + (NSTimeInterval)inheritedAnimationDuration NS_AVAILABLE_IOS(9_0);
 #endif
 
 @end
 
 @interface UIView(UIViewAnimationWithBlocks)
 
 + (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);
 
 + (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0); // delay = 0.0, options = 0
 
 + (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations NS_AVAILABLE_IOS(4_0); // delay = 0.0, options = 0, completion = NULL
 
 /* Performs `animations` using a timing curve described by the motion of a spring. When `dampingRatio` is 1, the animation will smoothly decelerate to its final model values without oscillating. Damping ratios less than 1 will oscillate more and more before coming to a complete stop. You can use the initial spring velocity to specify how fast the object at the end of the simulated spring was moving before it was attached. It's a unit coordinate system, where 1 is defined as travelling the total animation distance in a second. So if you're changing an object's position by 200pt in this animation, and you want the animation to behave as if the object was moving at 100pt/s before the animation started, you'd pass 0.5. You'll typically want to pass 0 for the velocity.
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);

+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);  toView added to fromView.superview, fromView removed from its superview

/* Performs the requested system-provided animation on one or more views. Specify addtional animations in the parallelAnimations block. These additional animations will run alongside the system animation with the same timing and duration that the system animation defines/inherits. Additional animations should not modify properties of the view on which the system animation is being performed. Not all system animations honor all available options.
 
+ (void)performSystemAnimation:(UISystemAnimation)animation onViews:(NSArray<__kindof UIView *> *)views options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))parallelAnimations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

@end

@interface UIView (UIViewKeyframeAnimations)

+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);
+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations NS_AVAILABLE_IOS(7_0);  start time and duration are values between 0.0 and 1.0 specifying time and duration relative to the overall time of the keyframe animation

*/
