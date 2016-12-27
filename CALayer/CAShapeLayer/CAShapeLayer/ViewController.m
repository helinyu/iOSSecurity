//
//  ViewController.m
//  CAShapeLayer
//
//  Created by felix on 2016/12/27.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ViewController.h"
#import "CAShapeLayer+ViewMask.h"
#import "AudioIconView.h"
#import "ProgressView.h"
#import "ProgressView.h"

@interface ViewController ()<ProgressViewProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self test0];
//    [self test1] ;
    [self test2];
}

// 绘画进度条
- (void)test2 {
    ProgressView *progressView = [[ProgressView alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth([UIScreen mainScreen].bounds),20)];
    progressView.backgroundColor = [UIColor grayColor];
    progressView.delegate.name = @"hello"; //
    [progressView startProgress];
    [self.view addSubview:progressView];
}

// 实现一个音频效果的图标
- (void)test1 {
    // 这里设置死的大小是size(100,100)
    AudioIconView *aiView = [[AudioIconView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    aiView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:aiView];
}

// 实现对应的mask 界面
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
