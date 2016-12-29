//
//  TransitionView.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/29.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "TransitionView.h"

/// 转场的效果
#define IMAGE_COUNT 10

@interface TransitionView ()
{
    UIImageView *_imageView;
    int _currentIndex;
}

@end

@implementation TransitionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //定义图片控件
        _imageView=[[UIImageView alloc]init];
        _imageView.frame=[UIScreen mainScreen].applicationFrame;
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        _imageView.image=[UIImage imageNamed:@"Snip20161229_0.png"];//默认图片
        [self addSubview:_imageView];
        
        //添加手势
        UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
        leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:leftSwipeGesture];
        
        UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
        rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightSwipeGesture];
    }
    return self;
}

#pragma mark 向左滑动浏览下一张图片
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}

#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext{
 
    //1.创建转场动画对象
    CATransition *transition=[[CATransition alloc]init];
    
    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type=@"cube";
    
    //设置子类型
    if (isNext) {
        transition.subtype=kCATransitionFromRight;
    }else{
        transition.subtype=kCATransitionFromLeft;
    }
    //设置动画时常
    transition.duration = 1.0f;
    
    //3.设置转场后的新视图添加转场动画
    _imageView.image=[self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex=(_currentIndex+1)%IMAGE_COUNT;
    }else{
        _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"Snip20161229_%i.png",_currentIndex];
    return [UIImage imageNamed:imageName];
}

@end

/*
 转场动画：这个过程效果有的时候可能就是用在“轮播图片”
 
 @interface CATransition : CAAnimation
 
 @property(copy) NSString *type; 转成动画类型  `fade', `moveIn', `push' and `reveal
 @property(nullable, copy) NSString *subtype; 设置了从左边还是右边进行转场
 
 @property float startProgress;
 @property float endProgress;
 [0,1] 有关的内容的处理；
 
 @property(nullable, strong) id filter;
 一个可选的过滤，type、subtype 设置的话，这个属性就会忽略掉，必须实现inputImage、outputImage，可能实现inputExtent关键字，用于描述区域转场和和运行。默认是nil
 
 Common transition types.
 CA_EXTERN NSString * const kCATransitionFade
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCATransitionMoveIn
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCATransitionPush
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCATransitionReveal
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 
 Common transition subtypes.
 CA_EXTERN NSString * const kCATransitionFromRight
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCATransitionFromLeft
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCATransitionFromTop
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCATransitionFromBottom
 CA_AVAILABLE_STARTING (10.5, 2.0, 9.0, 2.0);

*/
