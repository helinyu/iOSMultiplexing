//
//  MediaTimingVC.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/13.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "MediaTimingVC.h"

@interface MediaTimingVC ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITextField *durationField;
@property (nonatomic, strong) UITextField *repeatField;
@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) CALayer *shipLayer;

@property (strong, nonatomic) UIView *contrainerView2;

@property (strong, nonatomic) UILabel *speedLabel;
@property (strong, nonatomic) UILabel *timeOffsetLabel;
@property (strong, nonatomic) UISlider *speedSlider;
@property (strong, nonatomic) UISlider *timeOffsetSlider;
@property (strong, nonatomic) UIBezierPath *bezierPath;

@end

@implementation MediaTimingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) -64)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];

//    [self test1]; // 基本上重复属性
//    [self test2]; // 基本的旋转
    [self test3];
    
}

- (void)test1 {
    //add the ship
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(100, 100, 100, 100);
    self.shipLayer.position = CGPointMake(150, 150);
    self.shipLayer.backgroundColor = [UIColor greenColor].CGColor;
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Snip20170113_1.png"].CGImage; // 存放的图片和大小不要差别太大
    [self.containerView.layer addSublayer:self.shipLayer];
    
    self.repeatField = [[UITextField alloc] initWithFrame:CGRectMake(50, 350, 50, 40)];
    self.durationField = [[UITextField alloc] initWithFrame:CGRectMake(150, 350, 50, 40)];
    self.repeatField.placeholder = @"repeat count";
    self.durationField.placeholder = @"duration number";
    [self.containerView addSubview:self.repeatField];
    [self.containerView addSubview:self.durationField];
    
    self.startButton = [[UIButton alloc] initWithFrame:CGRectMake(250, 350, 50, 50)];
    self.startButton.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:self.startButton];
    [self.startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setControlsEnabled:(BOOL)enabled
{
    for (UIControl *control in @[self.durationField, self.repeatField, self.startButton]) {
        control.enabled = enabled;
        control.alpha = enabled? 1.0f: 0.25f;
    }
}

- (void)hideKeyboard
{
    [self.durationField resignFirstResponder];
    [self.repeatField resignFirstResponder];
}

- (void)start
{
    CFTimeInterval duration = [self.durationField.text doubleValue];
    float repeatCount = [self.repeatField.text floatValue];
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = duration;
//    创建重复动画的另一种方式是使用repeatDuration属性，它让动画重复一个指定的时间，而不是指定次数。
    animation.repeatCount = repeatCount;
    animation.byValue = @(M_PI * 2);
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    //disable controls
    [self setControlsEnabled:NO];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //reenable controls
    [self setControlsEnabled:YES];
}

//（2）摆动门的动画
// 我们用了autoreverses来使门在打开后自动关闭，在这里我们把repeatDuration设置为INFINITY，于是动画无限循环播放，设置repeatCount为INFINITY也有同样的效果。注意repeatCount和repeatDuration可能会相互冲突，所以你只要对其中一个指定非零值。对两个属性都设置非0值的行为没有被定义。+
- (void)test2 {
    CALayer *doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    doorLayer.position = CGPointMake(150 - 64, 150);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
    doorLayer.contents = (__bridge id)[UIImage imageNamed: @"Snip20170113_1.png"].CGImage;
    [self.containerView.layer addSublayer:doorLayer];
    //apply perspective transform
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    //apply swinging animation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 2.0;
    animation.repeatDuration = INFINITY;
    animation.autoreverses = YES;
    [doorLayer addAnimation:animation forKey:nil];
}

// （3）相对时间
- (void)test3 {
    
    //
    _speedLabel = [UILabel new];
    _speedLabel.text = @"speed";
//    _speedLabel.contentMode =
    [self.view addSubview:_speedLabel];
    
    _timeOffsetLabel.text = @"timeOffset";
    
    //create a path
    self.bezierPath = [[UIBezierPath alloc] init];
    [self.bezierPath moveToPoint:CGPointMake(0, 150)];
    [self.bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = self.bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    //add the ship
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
    self.shipLayer.position = CGPointMake(0, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Ship.png"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
    //set initial values
    [self updateSliders];
}

- (void)updateSliders
{
    CFTimeInterval timeOffset = self.timeOffsetSlider.value;
    self.timeOffsetLabel.text = [NSString stringWithFormat:@"%0.2f", timeOffset];
    float speed = self.speedSlider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"%0.2f", speed];
}

- (void)play
{
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.timeOffset = self.timeOffsetSlider.value;
    animation.speed = self.speedSlider.value;
    animation.duration = 1.0;
    animation.path = self.bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = NO;
    [self.shipLayer addAnimation:animation forKey:@"slide"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
/*
 CAMediaTiming协议定义了在一段动画内用来控制逝去时间的属性的集合，CALayer和CAAnimation都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制。
 甚至设置一个叫做autoreverses的属性（BOOL类型）在每次间隔交替循环过程中自动回放。这对于播放一段连续非循环的动画很有用，例如打开一扇门，然后关上它。
 甚至设置一个叫做autoreverses的属性（BOOL类型）在每次间隔交替循环过程中自动回放
这对于播放一段连续非循环的动画很有用，例如打开一扇门，然后关上它。
*/
