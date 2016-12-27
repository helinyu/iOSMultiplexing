//
//  CAShapeLayer+ViewMask.h
//  test_shapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>

@interface CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView : (UIView *)view;

@end
