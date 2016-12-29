//
//  CustomLayer.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/29.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "CustomLayer.h"

@implementation CustomLayer

- (void)drawInContext:(CGContextRef)ctx {
    
}

@end


/*

CATiledLayer 平铺layer （DTCoreText 中的DTTiledLayerWithoutFade 、或DTAttributedTextContentView 都是用早这个layer）
应该就是将绘画平铺出去；
+ (CFTimeInterval)fadeDuration; 消退的时间（淡出的时间）
@property size_t levelsOfDetail;  细节等级；默认是1。如果这个值被设置为很多值，最后会设置为最大值。LOD必须包括一个像素在每个维度上。
@property size_t levelsOfDetailBias;偏置细节等级 ，layer细节上的放大，默认是0，2 表示放大2倍
@property CGSize tileSize; 铺平的大小 每一个tile 用于创建layer的内容，默认是（256*256），注意，这个是最大的瓦片大小，要求瓦片大于限制而使大小合适。

 DTCoreText 的内容就使用了这个类来进行处理；需要去考虑如何进行处理； 
 


*/
