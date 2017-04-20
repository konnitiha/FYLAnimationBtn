//
//  ViewController.m
//  FYLAnimationBtn
//
//  Created by FuYunLei on 2017/4/20.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "ViewController.h"
#import "FYLAnimationBtn.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     !!!:FYLAnimationBtn 将被强制修改为正方形
     
     */
    FYLAnimationBtn *btn = [[FYLAnimationBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick:(FYLAnimationBtn *)btn{
    btn.selected = !btn.isSelected;
}

@end
