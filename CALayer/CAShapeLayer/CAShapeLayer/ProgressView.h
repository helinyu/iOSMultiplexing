
//
//  ProgressView.h
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProgressViewProtocol <NSObject>

@property (nonatomic, strong,nullable) NSString *name;
//协议里面的属性应该怎么样进行使用 ，同样直接使用？？？
@end


@interface ProgressView : UIView

- (void)startProgress;

@property (weak, nonatomic) id<ProgressViewProtocol> delegate;

@end
