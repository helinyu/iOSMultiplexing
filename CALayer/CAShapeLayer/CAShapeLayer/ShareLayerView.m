//
//  ShareLayerView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/29.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ShareLayerView.h"

@interface ShareLayerView()<CAAnimationDelegate>
{
    UIBezierPath    *_path;
}

@property (strong, nonatomic) CAShapeLayer *progressLayer;

@end

const CGFloat LayerWidth = 20.0f;
const CGFloat LayerHeight = 20.0f;
const CGFloat PistionY = 30.0f;

@implementation ShareLayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _path = [UIBezierPath bezierPath];
        [_path moveToPoint:CGPointMake(0,  PistionY)];
        [_path addLineToPoint:CGPointMake(LayerWidth,PistionY)];

        self.backgroundColor = [UIColor grayColor];
        CAShapeLayer *progressLayer = [CAShapeLayer layer];
        progressLayer.path = _path.CGPath;
        progressLayer.strokeColor = [[UIColor redColor] CGColor];
        progressLayer.fillColor = [[UIColor clearColor] CGColor];
        progressLayer.lineWidth = LayerHeight;
        progressLayer.strokeEnd = 0.0f;
        _progressLayer = progressLayer;
        [self.layer addSublayer:progressLayer];
        
        [self renderProgress];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;// 填充空区域，笔画中油连带，有弯曲的地方就会填充颜色
    shapeLayer.lineWidth = 20;
    shapeLayer.lineJoin = kCALineJoinMiter; // 也即是斜接的时候是接着的（两个线段之间的关系）
    shapeLayer.lineCap = kCALineCapRound; //  设置角是圆的
    shapeLayer.path = path.CGPath;
    shapeLayer.miterLimit = 0;
    
    UIBezierPath *namePath = [UIBezierPath new];
    [namePath moveToPoint:CGPointMake(20, 200)];
    [namePath addLineToPoint:CGPointMake(60, 200)];
    [namePath moveToPoint:CGPointMake(20, 200)];
    [namePath addLineToPoint:CGPointMake(20, 350)];
    [namePath moveToPoint:CGPointMake(20, 260)];
    [namePath addLineToPoint:CGPointMake(55, 260)];
    // F
    
    // E
    [namePath moveToPoint:CGPointMake(80, 260)];
    [namePath addLineToPoint:CGPointMake(130, 260)];
    [namePath addArcWithCenter:CGPointMake(100, 260) radius:30.0f startAngle:0 endAngle:((M_PI/8)-(M_PI*2)) clockwise:false];
// 这里需要上下翻转一下
    
    // L
    [namePath moveToPoint:CGPointMake(140, 200)];
    [namePath addLineToPoint:CGPointMake(140, 350)];
    [namePath addLineToPoint:CGPointMake(210, 350)];
    
    // I
    [namePath moveToPoint:CGPointMake(220, 200)];
    [namePath addLineToPoint:CGPointMake(220, 350)];
    
    // X
    [namePath moveToPoint:CGPointMake(230, 200)];
    [namePath addLineToPoint:CGPointMake(280, 350)];
    [namePath moveToPoint:CGPointMake(280, 200)];
    [namePath addLineToPoint:CGPointMake(230, 350)];
    
    
    CAShapeLayer *nameLayer = [CAShapeLayer layer];
    nameLayer.strokeColor = [UIColor blueColor].CGColor;
    nameLayer.fillColor = [UIColor clearColor].CGColor;
    nameLayer.lineWidth = 5.0f;
    nameLayer.lineCap = kCALineCapSquare;
    nameLayer.lineJoin = kCALineJoinMiter;
    nameLayer.path = namePath.CGPath;
    
//    self.progressLayer.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 20);
//    self.progressLayer.strokeColor = [UIColor redColor].CGColor;
//    self.progressLayer.fillColor = [UIColor greenColor].CGColor;
//    [self.layer addSublayer:self.progressLayer];
    
//    [self.layer addSublayer:nameLayer];

    //add it to our view
//    [self.layer addSublayer:shapeLayer];
}

- (void)renderProgress {
       CABasicAnimation* strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.duration = 30;
        strokeEndAnimation.fromValue = @(0);
        strokeEndAnimation.toValue = @(CGRectGetWidth([UIScreen mainScreen].bounds));
        strokeEndAnimation.autoreverses = NO;
        strokeEndAnimation.repeatCount = 0.0f;
        strokeEndAnimation.delegate = self;
    
        [_progressLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
}


/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animationDidStart");
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop");
}

@end
