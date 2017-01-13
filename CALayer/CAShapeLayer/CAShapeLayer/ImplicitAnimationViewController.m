//
//  TransitionViewController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/12.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "ImplicitAnimationViewController.h"
#import "TransitionViewController.h"
#import "FinishBlockViewController.h"
#import "LayerBehaviorViewController.h"

@interface ImplicitAnimationViewController ()
@property (strong, nonatomic) NSArray *datasources;
@end

@implementation ImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    _datasources = @[@"事务",@"完成块",@"图层行为"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _datasources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = _datasources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            TransitionViewController *vc = [TransitionViewController new];
            vc.title = _datasources[indexPath.row];
            vc.view.backgroundColor = [UIColor grayColor];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 1:
        {
            FinishBlockViewController *vc = [FinishBlockViewController new];
            vc.title = _datasources[indexPath.row];
            vc.view.backgroundColor = [UIColor grayColor];
            [self.navigationController pushViewController:vc animated:true];
            
        }
            break;
        case 2:
        {
            LayerBehaviorViewController *vc = [LayerBehaviorViewController new];
            vc.view.backgroundColor = [UIColor grayColor];
            vc.title = _datasources[indexPath.row];
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
