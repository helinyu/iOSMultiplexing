//
//  CustomViewController.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/30.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ShapeLayerController.h"
#import "ShapeLayerView.h"

@interface ShapeLayerController ()

@end

@implementation ShapeLayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    ShapeLayerView *sLayerView = [[ShapeLayerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:sLayerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
