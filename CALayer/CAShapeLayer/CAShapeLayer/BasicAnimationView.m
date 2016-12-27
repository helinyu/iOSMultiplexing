//
//  BasicAnimationView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "BasicAnimationView.h"

@interface BasicAnimationView ()
{
    CALayer *_layer;
}

@end

@implementation BasicAnimationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 下面是一个平移的动作

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景(注意这个图片其实在根图层)
//        UIImage *backgroundImage = [UIImage imageNamed:@"background.jpg"];
//        self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
        self.backgroundColor = [UIColor grayColor];
        
        //自定义一个图层
        _layer=[[CALayer alloc]init];
        _layer.bounds=CGRectMake(0, 0, 10, 20);
        _layer.position=CGPointMake(50, 150);
        _layer.contents=(id)[UIImage imageNamed:@"petal.png"].CGImage;
        [self.layer addSublayer:_layer];
    }
    return self;
}

#pragma mark 移动动画
-(void)translatonAnimation:(CGPoint)location{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    
    //2.设置动画属性初始值和结束值
//        basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
    basicAnimation.toValue=[NSValue valueWithCGPoint:location];
    
    //设置其他动画属性
    basicAnimation.duration=5.0;//动画时间5秒
    //basicAnimation.repeatCount=HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
    //    basicAnimation.removedOnCompletion=NO;//运行一次是否移除动画
    
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}



@end
