//
//  ViewController.m
//  NSLog
//
//  Created by felix on 2017/1/10.
//  Copyright © 2017年 felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

#define CustomSelectorLog NSLog(@"selector :%@",NSStringFromSelector(_cmd))
#define LogFunAndLine(object) NSLog(@"%s:%d object=%@",__func__,__LINE__,object)

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test0];
    [self customLog];
}

- (void)customLog {
    NSLog(@"");
    CustomSelectorLog;
    NSMutableArray *someObject = [NSMutableArray array];
    LogFunAndLine(someObject);
    [someObject addObject:@"foo"];
    LogFunAndLine(someObject);
}

- (void)test0 {
    NSLog(@"selector :%@",NSStringFromSelector(_cmd)); // current method
    NSLog(@"class : %@",NSStringFromClass([self class])); // current object's class
    NSLog(@"file : %@ ",[[NSString stringWithUTF8String:__FILE__] lastPathComponent]); //Name of the source code file.
    NSLog(@"call statck symbols : %@",[NSThread callStackSymbols]); //NSArray of the current stack trace as programmer-readable strings.这个一般是有崩溃的时候才会输出
    NSMutableArray *someObject = [NSMutableArray array];
    NSLog(@"%s:%d someObject=%@", __func__, __LINE__, someObject);
    [someObject addObject:@"foo"];
    NSLog(@"%s:%d someObject=%@", __func__, __LINE__, someObject);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
