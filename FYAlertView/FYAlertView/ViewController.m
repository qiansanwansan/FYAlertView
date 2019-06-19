//
//  ViewController.m
//  FYAlertView
//
//  Created by 冯宇的Mac mini on 2019/6/19.
//  Copyright © 2019 冯宇的Mac mini. All rights reserved.
//

#import "ViewController.h"
#import "FYAlertView.h"
#import "UIView+FYFrame.h"
@interface ViewController ()

@end

@implementation ViewController


#pragma mark --- 弹窗点击事件
- (void)alertSureButtonClick{
    NSLog(@"点击了确认按钮");
}

- (void)alertCauseButtonClick{
    NSLog(@"点击了取消按钮");
}
-(void)fyAlertTFValueChanged:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    FYAlertView * alertView = [[FYAlertView alloc] initWithTittle:@"姓名" placeholder:@"请输入姓名" target:self tfKeyboardType:UIKeyboardTypeDefault block:^(ClickAlertBtnType type) {
        if (type == FY_ClickAlertBtnTypeEnsure) {
            [self alertSureButtonClick];
        }else{
            [self alertCauseButtonClick];
        }
    }];
    [alertView show];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
