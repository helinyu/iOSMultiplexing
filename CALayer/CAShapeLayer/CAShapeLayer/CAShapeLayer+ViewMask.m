//
//  CAShapeLayer+ViewMask.m
//  test_shapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "CAShapeLayer+ViewMask.h"

@implementation CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView : (UIView *)view{
   
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    CGFloat rightSpace = 10;
    CGFloat topSpace = 15;
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth+rightSpace, 0);
    // 注意以这个view为边界，也就是具有覆盖的作用
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:point1];  // 刚开始，移动画笔的位置
    [path addLineToPoint:point2]; // 添加线段的下一个点
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    [path closePath];  // 结束画笔的内容 （也就是相当于提起这个笔尖）
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    return layer;
}

@end
