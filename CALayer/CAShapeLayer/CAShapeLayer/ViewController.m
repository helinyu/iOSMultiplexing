//
//  ViewController.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayer+ViewMask.h"
#import "AudioIconView.h"
#import "ProgressView.h"
#import "AnimationLayerView.h"
#import "BasicAnimationView.h"
#import "KeyFrameAnimationView.h"
#import "SpringAnimationView.h"
#import "GroupAnimationView.h"
#import "TransitionView.h"
#import "FrameByFrameAnimationView.h"
#import "ShapeLayerView.h"
#import "CAViewController.h"

@interface ViewController ()<ProgressViewProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];

//    [self test0];
//    [self test1] ;
//    [self test2];
//    [self testAnimationLayerView];
//    [self testBasicAnimationView];
//    [self testKeyFrameAnimation];
//    [self testSpringAnimation];
//    [self testUIViewAnimaiton];
//    [self testGroupAnimation];
//    [self testTrainsition];
//    [self testFrameByFrame];
//    [self testShapeLayer];
    [self toCAViewController];
}

- (void)toCAViewController {
//    CAViewController *vc = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CAViewController class]) owner:self options:nil] lastObject];
    CAViewController *vc = [[CAViewController alloc] initWithNibName:NSStringFromClass([CAViewController class]) bundle:nil];
    [self.navigationController pushViewController:vc animated:true];
}

// 绘画形状的layer
- (void)testShapeLayer {
    ShapeLayerView *slView = [[ShapeLayerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:slView];
}

// 逐帧动画
- (void)testFrameByFrame {
    FrameByFrameAnimationView *fbfAnimationView = [[FrameByFrameAnimationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:fbfAnimationView];
}

// 转场动画
- (void)testTrainsition {
    TransitionView *tsView = [[TransitionView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:tsView];
}

- (void)testGroupAnimation {
    GroupAnimationView *gaView = [[GroupAnimationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:gaView];
}


// UIView层的动画 （关于动画的内容，还有其他方法）
- (void)testUIViewAnimaiton {
    [UIView animateWithDuration:3.0 delay:1.0 usingSpringWithDamping:1.0f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.alpha = 0; //浑浊度发生了变化
    } completion:^(BOOL finished) {
        
    }];
}

- (void)testSpringAnimation {
    SpringAnimationView *springAView = [[SpringAnimationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:springAView];
}

/// test key frame aniamtion
- (void)testKeyFrameAnimation {
    KeyFrameAnimationView *keyFrameAView =[[KeyFrameAnimationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:keyFrameAView];
}

// test basic animation with rotation and so on
- (void)testBasicAnimationView {
    BasicAnimationView *basicView = [[BasicAnimationView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:basicView];
//    [basicView translatonAnimation:CGPointMake(300, 300)];
}

//1.初始化动画并设置动画属性
//2.设置动画属性初始值（可以省略）、结束值以及其他动画属性
//3.给图层添加动画
-(void)testAnimationLayerView {
    AnimationLayerView *bAView = [[AnimationLayerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:bAView];
//    [bAView translatonAnimation:CGPointMake(300, 300)];
    [bAView translatonAnimationChanged:CGPointMake(300, 300)];
    
}

// 绘画进度条
- (void)test2 {
    ProgressView *progressView = [[ProgressView alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth([UIScreen mainScreen].bounds),20)];
    progressView.backgroundColor = [UIColor grayColor];
    progressView.delegate.name = @"hello"; //
    [progressView startProgress];
    [self.view addSubview:progressView];
}

// 实现一个音频效果的图标
- (void)test1 {
    // 这里设置死的大小是size(100,100)
    AudioIconView *aiView = [[AudioIconView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    aiView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:aiView];
}

// 实现对应的mask 界面
- (void)test0 {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 50, 80, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:view];
    view.layer.mask = layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
