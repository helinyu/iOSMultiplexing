//
//  ProgressView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()<CAAnimationDelegate>
{
    UIBezierPath *_path;
    NSMutableArray *_fragmentEnds;
    BOOL _hasLayoutSubviews;
}

@property (strong, nonatomic) CAShapeLayer *progressLayer;
@property (strong, nonatomic) CALayer *backLayer;
@property (strong, nonatomic) NSMutableArray *splitLayers;
@property (assign, nonatomic, readonly) BOOL backProgress;

@end

@implementation ProgressView

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"子视图");
}

- (void)startProgress {
    CGFloat duration = 30;//self.maxProgressTime * (1.0f - _progressLayer.strokeEnd);
    CGFloat strokeEndFinal = 1.0f;
    
    CABasicAnimation *strokeEndAnimation = nil;
    strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = duration;
    strokeEndAnimation.fromValue = @(_progressLayer.strokeEnd);
    strokeEndAnimation.toValue = @(strokeEndFinal);
    strokeEndAnimation.autoreverses = NO;
    strokeEndAnimation.repeatCount = 0.0f;
    strokeEndAnimation.delegate = self;
    [_progressLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
}

- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.delegate.name = @"hello";
}

@end
