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

@property (nonatomic, strong) BJNoDataView *noDataView;
@end

@implementation MZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.noDataView showWithSuper:self.view Frame:self.view.frame icon:@"icon"];
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
    }else
    {
        [MyControl setAlertInfo:@"你手机型号不是 7P" andSuperview:self.view];
    }
}

- (BJNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [BJNoDataView shareNoDataView];
        _noDataView.frame = self.view.bounds;
    }
    return _noDataView;
}

@end
