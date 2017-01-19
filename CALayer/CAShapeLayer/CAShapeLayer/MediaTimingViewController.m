//
//  MediaTimingViewController.m
//  CAShapeLayer
//
//  Created by felix on 2017/1/13.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "MediaTimingViewController.h"
#import "MediaTimingVC.h"

@interface MediaTimingViewController ()

@property (strong, nonatomic) NSArray *dataSources;

@end

@implementation MediaTimingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSources = @[@"CAMediaTiming协议"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = _dataSources[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            MediaTimingVC *vc = [MediaTimingVC new];
            vc.view.backgroundColor = [UIColor grayColor];
            vc.title = _dataSources[indexPath.row];
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

/*
看看CAMediaTiming，看看Core Animation是如何跟踪时间的。
 
*/

@end
