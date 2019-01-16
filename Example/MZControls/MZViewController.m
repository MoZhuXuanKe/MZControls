//
//  MZViewController.m
//  MZControls
//
//  Created by mozhu on 01/15/2019.
//  Copyright (c) 2019 mozhu. All rights reserved.
//

#import "MZViewController.h"
#import <MZControls/MZControls-umbrella.h>

@interface MZViewController ()

@end

@implementation MZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MyControl setAlertInfo:@"加载完成!!!" andSuperview:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([MyControl is_iPhone7P]) {
        [MyControl setAlertInfo:@"你手机型号当前是 iPhone7 Plus" andSuperview:self.view];
    }
}

@end
