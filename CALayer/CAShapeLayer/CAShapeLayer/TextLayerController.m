//
//  CATextLayerController.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/30.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "TextLayerController.h"

@interface TextLayerController ()

@property (strong, nonatomic) CATextLayer *textLayer;

@end

@implementation TextLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    
    //set layer text
    textLayer.string = text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

/*
这里的字符串的属性都是string类型而不是 NSAttributedString类型
 
 @property(nullable, copy) id string;
 默认是nil，可以说会 NSString / NSAttributedStringu

@property(nullable) CFTypeRef font; 
 Helvetica font 默认字体 CTFontRef, a CGFontRef NSString类型

@property CGFloat fontSize;
默认是36 ，string 类型不是 NSAttributedString

@property(nullable) CGColorRef foregroundColor;
前面的颜色，默认是变色不透明，
 
@property(getter=isWrapped) BOOL wrapped;
 默认是no,true的时候就包括边界
 
@property(copy) NSString *truncationMode;
none', `start', `middle' and`. Defaults to `none 截断模式
 
@property(copy) NSString *alignmentMode;
`natural', `left', `right', `center' and `justified'. Defaults to `natural' 对齐模式

@property BOOL allowsFontSubpixelQuantization;
 allowsFontSubpixelQuantization 这个参数允许将这个CGContextRef 传给-drawInContext: 这个方法，默认是no。

PS:
 完全可以借助图层代理直接将字符串使用Core Graphics写入图层的内容（这就是UILabel的精髓）
 含了UILabel几乎所有的绘制特性，并且额外提供了一些新的特性
 CATextLayer也要比UILabel渲染得快得多
 很少有人知道在iOS 6及之前的版本，UILabel其实是通过WebKit来实现绘制的，这样就造成了当有很多文字的时候就会有极大的性能压力。而CATextLayer使用了Core text，并且渲染得非常快。
 
 (如果性能比哪个高的话，为什么要使用UIlabel呢？直接使用textLayer就可以了？)
 
 
这里面应该在DTcoreText上也会使用功能到的内容可以进行查看，种类应该也是用于系那是头像等等特殊的字符，图片相当于文字显示。
 
 
 */
