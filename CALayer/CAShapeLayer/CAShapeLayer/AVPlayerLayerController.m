//
//  AVPlayerLayerController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/5.
//  Copyright © 2017年 felix. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "AVPlayerLayerController.h"

@interface AVPlayerLayerController ()

@property (strong, nonatomic) UIView *containerView;

@end

@implementation AVPlayerLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0,64,[[UIScreen mainScreen] bounds].size.width,200)];
    self.containerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.containerView];
    
    //get video URL
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"test0" withExtension:@"mp4"];
    
//    NSURL *URL = [NSURL URLWithString:@"http://localhost:8000/movie/test0.mp4"];
    
    //create player and player layer
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    //set player layer frame and attach it to our view
    playerLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:playerLayer];
    
    //界面的另外处理 具有CALayer的一切属性
    //transform layer
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    playerLayer.transform = transform;

    //add rounded corners and border
    playerLayer.masksToBounds = YES;
    playerLayer.cornerRadius = 20.0;
    playerLayer.borderColor = [UIColor redColor].CGColor;
    playerLayer.borderWidth = 5.0;
    
    //play the video
    [player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


/*
我们用代码创建了一个AVPlayerLayer，但是我们仍然把它添加到了一个容器视图中，而不是直接在controller中的主视图上添加。这样其实是为了可以使用自动布局限制使得图层在最中间；否则，一旦设备被旋转了我们就要手动重新放置位置，因为Core Animation并不支持自动大小和自动布局（见第三章『图层几何学』）。

 因为AVPlayerLayer是CALayer的子类，它继承了父类的所有特性。我们并不会受限于要在一个矩形中播放视频；清单6.16演示了在3D，圆角，有色边框，蒙板，阴影等效果
 
 + (AVPlayerLayer *)playerLayerWithPlayer:(nullable AVPlayer *)player;
和AVPlayer是紧密连接起来的
 
 @property (nonatomic, retain, nullable) AVPlayer *player;
通过PlayerLayer可以读取对应的Player的内容
 
 @property(copy) NSString *videoGravity;
设置权重，就是显示的方式
 
 @property(nonatomic, readonly, getter=isReadyForDisplay) BOOL readyForDisplay;
是否准备播放
 
 @property (nonatomic, readonly) CGRect videoRect NS_AVAILABLE(10_9, 7_0);
video 的大小
 
 @property (nonatomic, copy, nullable) NSDictionary<NSString *, id> *pixelBufferAttributes NS_AVAILABLE(10_11, 9_0);

 mark：帧率和像素的处理
 
*/
