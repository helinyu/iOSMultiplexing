//
//  BasicAnimationView.h
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationLayerView : UIView

-(void)translatonAnimation:(CGPoint)location;// 平移又会回到起点 （default）
-(void)translatonAnimationChanged:(CGPoint)location;  // 平移后留在末端（manual deal with）

@end
