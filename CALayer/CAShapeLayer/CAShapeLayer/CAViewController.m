//
//  CAViewController.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/30.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "CAViewController.h"
#import "ShapeLayerController.h"
#import "TiledLayerController.h"
#import "TextLayerController.h"
#import "EAGLLayerViewController.h"
#import "AVPlayerLayerController.h"


@interface CAViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataSources;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CAViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSources = @[@"CAShapeLayer",@"TiledLayer",@"TextLayer",@"CAEAGLLayer",@"AVPlayerLayer"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
}

#pragma mark -- UItableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = _dataSources[indexPath.row];
    return cell;
}

#pragma mark -- delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            ShapeLayerController *slVC = [[ShapeLayerController alloc] init];
            slVC.navigationItem.title = _dataSources[indexPath.row];
            [self.navigationController pushViewController:slVC animated:true];
        }
            break;
        case 1:
        {
            TiledLayerController *tlVC = [TiledLayerController new];
            tlVC.navigationItem.title = _dataSources[indexPath.row];
            [self.navigationController pushViewController:tlVC animated:true];
        }
            break;
        case 2:
        {
            TextLayerController *tlVC = [TextLayerController new];
            tlVC.navigationItem.title = _dataSources[indexPath.row];
            [self.navigationController pushViewController:tlVC animated:true];
        }
            break;
        case 3:
        {
            EAGLLayerViewController *tlVC = [EAGLLayerViewController new];
            tlVC.navigationItem.title = _dataSources[indexPath.row];
            [self.navigationController pushViewController:tlVC animated:true];
        }
            break;
        case 4:
        {
            AVPlayerLayerController *tlVC = [AVPlayerLayerController new];
            tlVC.navigationItem.title = _dataSources[indexPath.row];
            [self.navigationController pushViewController:tlVC animated:true];
        }
            break;
        default:
            NSLog(@"还没有对应的内容");
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
