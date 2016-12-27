//
//  ViewController.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayer+ViewMask.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test0];
    
}

- (void)test0 {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 50, 80, 100)];
    view.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view];
    CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:view];
    view.layer.mask = layer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
