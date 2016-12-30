//
//  TiledLayerController.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/30.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "TiledLayerController.h"

@interface TiledLayerController ()<CALayerDelegate>

@property (strong, nonatomic) CATiledLayer *tiledLayer;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation TiledLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    CATiledLayer *tiledLyaer = [CATiledLayer layer];
    tiledLyaer.frame = CGRectMake(0, 0, 2048, 2048);
    tiledLyaer.delegate = self;
    [self.view.layer addSublayer:tiledLyaer];
    self.scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(2048, 2048);
    [self.scrollView.layer addSublayer:tiledLyaer];
    self.tiledLayer = tiledLyaer;
    self.tiledLayer.contentsScale = [UIScreen mainScreen].scale/4;

 
    // draw layer
    [tiledLyaer setNeedsDisplay];
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx
{
    //determine tile coordinate
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    CGFloat scale = [UIScreen mainScreen].scale /4;
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width * scale);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height * scale);
    
    
    //load tile image
    NSString *imageName = [NSString stringWithFormat: @"Snip20161230_4_%02li_%02li", (long)x, (long)y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    
    //draw tile
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
 
 CATiledLayer 平铺layer （DTCoreText 中的DTTiledLayerWithoutFade 、或DTAttributedTextContentView 都是用早这个layer）
 应该就是将绘画平铺出去；
 + (CFTimeInterval)fadeDuration; 消退的时间（淡出的时间）
 @property size_t levelsOfDetail;  细节等级；默认是1。如果这个值被设置为很多值，最后会设置为最大值。LOD必须包括一个像素在每个维度上。
 @property size_t levelsOfDetailBias;偏置细节等级 ，layer细节上的放大，默认是0，2 表示放大2倍
 @property CGSize tileSize; 铺平的大小 每一个tile 用于创建layer的内容，默认是（256*256），注意，这个是最大的瓦片大小，要求瓦片大于限制而使大小合适。
 
 DTCoreText 的内容就使用了这个类来进行处理；需要去考虑如何进行处理；
 
 */

/*
 有些时候你可能需要绘制一个很大的图片，常见的例子就是一个高像素的照片或者是地球表面的详细地图。iOS应用通畅运行在内存受限的设备上，所以读取整个图片到内存中是不明智的。载入大图可能会相当地慢，那些对你看上去比较方便的做法（在主线程调用UIImage的-imageNamed:方法或者-imageWithContentsOfFile:方法）将会阻塞你的用户界面，至少会引起动画卡顿现象。
 关于需求：图片太大，一次性加载的时候，手机的资源消耗过大
 能高效绘制在iOS上的图片也有一个大小限制。所有显示在屏幕上的图片最终都会被转化为OpenGL纹理。（openGL 上面的内容就是纹理）同时OpenGL有一个最大的纹理尺寸（通常是2048*2048，或4096*4096，这个取决于设备型号）。
 如果你想在单个纹理中显示一个比这大的图，即便图片已经存在于内存中了，你仍然会遇到很大的性能问题，因为Core Animation强制用CPU处理图片而不是更快的GPU。
 CATiledLayer为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入。让我们用实验来证明一下。
 PS: 就是将大图片分块进行按需进行载入。
 https://zsisme.gitbooks.io/ios-/content/chapter6/catiledLayer.html
 
 CATiledLayer很好地和UIScrollView集成在一起。除了设置图层和滑动视图边界以适配整个图片大小，我们真正要做的就是实现-drawLayer:inContext:方法，当需要载入新的小图时，CATiledLayer就会调用到这个方法
 
这个类要搞懂，需要去看dtcoreText的内容
 
*/

@end
