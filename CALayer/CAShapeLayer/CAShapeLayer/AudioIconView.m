//
//  audioIcon.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "AudioIconView.h"

@implementation AudioIconView

- (void)refreshUIWithVoicePower:(NSInteger)voicePower{
//    CGFloat height = (voicePower)*(CGRectGetHeight(_dynamicView.frame)/TOTAL_NUM);
//    [_indicateLayer removeFromSuperlayer];
//    _indicateLayer = nil;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, CGRectGetHeight(_dynamicView.frame)-height, CGRectGetWidth(_dynamicView.frame), height) cornerRadius:0];
//    _indicateLayer = [CAShapeLayer layer];
//    _indicateLayer.path = path.CGPath;
//    _indicateLayer.fillColor = [UIColor whiteColor].CGColor;
//    [_dynamicView.layer addSublayer:_indicateLayer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        CGFloat viewWidth = CGRectGetWidth(self.frame);
//        CGFloat viewHeight = CGRectGetHeight(self.frame);
    //   添加对应的外面的内容
//        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 80, 80)];
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(20, 20)];
        [path addLineToPoint:CGPointMake(20, 45)];
        [path addLineToPoint:CGPointMake(50, 90)];
        [path addLineToPoint:CGPointMake(80, 45)];
        [path addLineToPoint:CGPointMake(80, 20)];
        [path addLineToPoint:CGPointMake(70, 20)];
        [path addLineToPoint:CGPointMake(70, 45)];
        [path addLineToPoint:CGPointMake(50, 70)];
        [path addLineToPoint:CGPointMake(30, 45)];
        [path addLineToPoint:CGPointMake(30, 20)];
//        [path addArcWithCenter:CGPointMake(50, 50) radius:2.0f startAngle:0.0f endAngle:2*M_PI clockwise:true];
        [path closePath];
        
        CAShapeLayer *drawLayer = [CAShapeLayer layer];
        drawLayer.backgroundColor = [UIColor redColor].CGColor;
        drawLayer.path = path.CGPath;
        [self.layer addSublayer:drawLayer];
        self.layer.masksToBounds = true;
    }
    return self;
}

@end
