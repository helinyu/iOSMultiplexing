//
//  FrameByFrameAnimationView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/29.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "FrameByFrameAnimationView.h"


@interface FrameByFrameAnimationView ()
{
    CALayer *_layer;
    int _index;
    NSMutableArray *_images;
}
@end

const NSInteger IMAGE_COUNT = 10;

@implementation FrameByFrameAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置背景
        self.layer.contents=(id)[UIImage imageNamed:@"bg.png"].CGImage;
        
        //创建图像显示图层
        _layer=[[CALayer alloc]init];
        _layer.bounds=CGRectMake(0, 0, 87, 32);
        _layer.position=CGPointMake(160, 284);
        [self.layer addSublayer:_layer];
        
        //由于鱼的图片在循环中会不断创建，而10张鱼的照片相对都很小
        //与其在循环中不断创建UIImage不如直接将10张图片缓存起来
        _images=[NSMutableArray array];
        for (int i=0; i<10; ++i) {
            NSString *imageName=[NSString stringWithFormat:@"Snip20161229_%i.png",i%4];
            UIImage *image=[UIImage imageNamed:imageName];
            [_images addObject:image];
        }
        
        //定义时钟对象
        CADisplayLink *displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
        //添加时钟对象到主运行循环
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [displayLink invalidate];
            displayLink.paused = true; //可以是吸纳了暂停
        });
        
//        if ([displayLink isPaused]) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                应该是那个targettime实现了重新启动
//            });
//        }
    }
    return self;
}


#pragma mark 每次屏幕刷新就会执行一次此方法(每秒接近60次)
-(void)step{
    //定义一个变量记录执行次数
    static int s=0;
    //每秒执行6次
    if (++s%10==0) {
        UIImage *image=_images[_index];
        _layer.contents=(id)image.CGImage;//更新图片
        _index=(_index+1)%IMAGE_COUNT;
    }
}

@end

/*
 逐帧动画
 （1）UIImageView，通过设置UIImageView的animationImages属性，然后调用它的startAnimating方法去播放这组图片
 缺点：它也存在着很大的性能问题，并且这种方法一旦设置完图片中间的过程就无法控制了。
 （2）NSTimer实现逐帧动画效果，种方式确实可以解决UIImageView一次性加载大量图片的问题，而且让播放过程可控，
 缺点：唯一的缺点就是定时器方法调用有时可能会因为当前系统执行某种比较占用时间的任务造成动画连续性出现问题。
 也就是进程的任务较重，是图片的播放终端，连续性受到了破坏。
 
 （3）通过核心动画 core animation 。没有直接的逐帧动画对象，不过可以通过CADisplayLink 这个相关对象
 CADisplayLink是一个计时器，但是同NSTimer不同的是，CADisplayLink的刷新周期同屏幕完全一致。例如在iOS中屏幕刷新周期是60次/秒，CADisplayLink刷新周期同屏幕刷新一致也是60次/秒，这样一来使用它完成的逐帧动画（又称为“时钟动画”）完全感觉不到动画的停滞情况。
 这样就决绝了NSTimer存在的问题。
 
ios启动后就是进入消息循环，开始等待用户输入。
将CADisplayLink 加入到主运行循环队列后就会循环调用目标方法。在这个方法中更新视图内容就可以逐帧动画。（难道是因为在主队列中占用了资源？？？）
当然这里不得不强调的是逐帧动画性能是必较低，但是对于一些事物的运动又不得不选择使用逐帧动画。？？？
例如人的运动，这是一个高度复杂的运动，基本动画、关键帧动画是不可能解决的。？？？？？
所大家一定要注意在循环方法中尽可能的降低算法复杂度，同时保证循环过程中内存峰值尽可能低。

 PS: 总结
 还是通过图片进行实现，图片的播放帧进行处理，不过就是，这里可以处理的动画比较复杂，可以让它在不同的模式下进行是吸纳，以及入会出现连续性的问题。eg:人的跑步的复杂动作。

？？？？ 虽然这个例子是这样用了，但是还是不明白实现人的动画的时候通过图片有什么不同和复杂？？？
 
 
 CADisplayLink  （显示链接）
 代表一个计时器会显示垂直同步（就是用在帧上面）
 
 为主显示器创建新的显示链接对象，这个方法就是sel，target 方法的对象；
 + (CADisplayLink *)displayLinkWithTarget:(id)target selector:(SEL)sel;
 
 - (void)addToRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode;
 添加到主运行对列中；
 添加了目标接受者（target）的displayLink 到对象中，除了暂停，他会执行在每个垂直同步上。
 一个对象只能够被加到一个单一的run-looop，但是可以添加多种模式。当添加了进入就会被隐式的retain。
 
 - (void)removeFromRunLoop:(NSRunLoop *)runloop forMode:(NSRunLoopMode)mode;
 也即是从模式中删除掉，隐式的release
 
 - (void)invalidate;
 这个方法是隐式release这个兑现的所有 模式；
 
 当前的时间、时长显示帧连E级到最近的target调用，时间表示使用普通的和兴动画转换，例如 ，Mach host（表示时间方式） 时间转化为秒
 @property(readonly, nonatomic) CFTimeInterval timestamp;
 @property(readonly, nonatomic) CFTimeInterval duration;
 
 @property(readonly, nonatomic) CFTimeInterval targetTimestamp CA_AVAILABLE_IOS_STARTING(10.0, 10.0, 3.0);
 // 下一次这个时间就会触发动作
 
 @property(getter=isPaused, nonatomic) BOOL paused;
 //  true的时候，这个对象就不会被启动
 
 
 @property(nonatomic) NSInteger frameInterval
 CA_AVAILABLE_BUT_DEPRECATED_IOS (3.1, 10.0, 9.0, 10.0, 2.0, 3.0, "use preferredFramesPerSecond");
 默认一次显示多少帧，这里的帧应该是一个间隔的的帧数
 Default value is one, which means the display link will fire for every display frame.
 （下面ios10的方法）
 @property(nonatomic) NSInteger preferredFramesPerSecond CA_AVAILABLE_IOS_STARTING(10.0, 10.0, 3.0);
 定义了回调的速率， 100 表示 回调100次/s ,
 默认是0 ，就是和硬件显示的平率一样。（虽然并不保证一定同步）核心动画会尽可能的做到。
 
 也就是这个动画实现了对应的帧率的控制以及卡顿上面的处理；

 
*/
