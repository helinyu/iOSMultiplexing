//
//  ReplicatorLayerController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/8.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "ReplicatorLayerController.h"

@interface ReplicatorLayerController ()

@property (strong, nonatomic) UIView *containerView;

@end

@implementation ReplicatorLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
//    我们在屏幕的中间创建了一个小白色方块图层，然后用CAReplicatorLayer生成十个图层组成一个圆圈。instanceCount属性指定了图层需要重复多少次。instanceTransform指定了一个CATransform3D3D变换
//    变换是逐步增加的，每个实例都是相对于前一实例布局。这就是为什么这些复制体最终不会出现在同意位置上self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0,64,[[UIScreen mainScreen] bounds].size.width,200)];
    [self.view addSubview:self.containerView];
  
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    //configure the replicator
    replicator.instanceCount = 11 ;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    
    //apply a color shift for each instance
    // 这里是设置对应的颜色的变化
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
//    [self setUp];
    
}

//这里社会了反射
- (void)setUp
{
    //configure replicator
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.containerView.layer;
    layer.instanceCount = 2;
    
    //move reflection instance below original and flip vertically
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = self.containerView.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    
    //reduce alpha of reflection layer
    layer.instanceAlphaOffset = -0.6;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

/*
原理：变换是逐步增加的，每个实例都是相对于前一实例布局。这就是为什么这些复制体最终不会出现在同意位置上
1)但是CReplicatorLayer真正应用到实际程序上的场景比如：一个游戏中导弹的轨迹云，或者粒子爆炸（尽管iOS 5已经引入了CAEmitterLayer，它更适合创建任意的粒子效果）
2）反射
使用CAReplicatorLayer并应用一个负比例变换于一个复制图层，你就可以创建指定视图（或整个视图层次）内容的镜像图片，这样就创建了一个实时的『反射』效果。
 让我们来尝试实现这个创意：指定一个继承于UIView的ReflectionView，它会自动产生内容的反射效果。实现这个效果的代码很简单（见清单6.9），实际上用ReflectionView实现这个效果会更简单，我们只需要把ReflectionView的实例放置于Interface Builder（见图6.9），它就会实时生成子视图的反射
 
 
 CAReplicatorLayer  ： 拷贝图层的作用（重复图层）
 -hitTest 这个方法只是会测试第一个图层（未来可能发生变化）
 
 @property NSInteger instanceCount;
 默认是1，创建和拷贝的内容
 
 @property BOOL preservesDepth;
 默认是no
 
 @property CFTimeInterval instanceDelay;
 
 @property CATransform3D instanceTransform;
 3D的转换
 
 @property(nullable) CGColorRef instanceColor;
 颜色
 
 @property float instanceRedOffset;
 @property float instanceGreenOffset;
 @property float instanceBlueOffset;
 @property float instanceAlphaOffset;
 差值

*/
