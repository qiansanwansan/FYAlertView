//
//  FYAlertView.m
//  FYtest
//
//  Created by 冯宇的Mac mini on 2019/6/18.
//  Copyright © 2019 冯宇的Mac mini. All rights reserved.
//

#import "FYAlertView.h"
#import "UIColor+FYColor.h"
#import "UIView+FYFrame.h"
#import "FYInitUIItem.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FYAlertView()

/** 弹窗主内容view */
@property (nonatomic,strong) UIView   *contentView;

/** 弹窗主内容view里的可变 View */
@property (nonatomic,strong) UIView   *mainView;

/** 弹窗标题 */
@property (nonatomic,copy)   NSString *title;

/** message */
@property (nonatomic,copy)   NSString *message;

/** 确认按钮 */
@property (nonatomic,copy)   UIButton *sureButton;

@property (nonatomic, strong) id superVC;

@property(nonatomic) UIKeyboardType keyboardType;

@property (nonatomic, copy) NSString *placeholder;

@end

@implementation FYAlertView
- (instancetype)initWithTittle:(NSString *)tittle placeholder:(NSString *)placeholder target:(id)target tfKeyboardType:(UIKeyboardType)keyboardType block:(void (^) (ClickAlertBtnType type))block{
    if (self = [super init]) {
        _title = tittle;
        _superVC = target;
        _fyAlertBtnClick = block;
        _keyboardType = keyboardType;
        _placeholder = placeholder;
        [self sutUpView];
    }
    return self;
}


- (void)sutUpView{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.85];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    
    //------- 弹窗主内容 -------//
    self.contentView = [FYInitUIItem viewWithFrame:CGRectMake(0, 0, 320, 150) backgroundColor:RGB(230, 230, 230)];
    self.contentView.center = self.center;
    self.contentView.layer.cornerRadius = 6;
    self.contentView.clipsToBounds = YES;
    [self addSubview:self.contentView];
    
    // 标题
    UILabel *titleLabel = [FYInitUIItem labelWithFrame:CGRectMake(0, 0, self.contentView.width, 42) title:self.title titleColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:19]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = RGB(247, 247, 247);
    
    [self.contentView addSubview:titleLabel];
    
    //------- 弹窗主内容 -------//
    self.mainView = [FYInitUIItem viewWithFrame:CGRectMake(0, 43, 320, 150-84) backgroundColor:[UIColor whiteColor]];
    [_contentView addSubview:self.mainView];
    
    UITextField *tf = [self textFieldWithFrame:CGRectMake(0, 10, _contentView.width,150-82-20) placeholder:_placeholder font:[UIFont systemFontOfSize:17]];
    [_mainView addSubview:tf];
    tf.keyboardType = UIKeyboardTypeDecimalPad;

    [tf addTarget:_superVC action:@selector(fyAlertTFValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    // 取消按钮
    UIButton * cancelBtn = [FYInitUIItem buttonWithFrame:CGRectMake(0, self.contentView.height - 40, self.contentView.width/2-0.5, 40) title:@"取消" titleColor:RGB(49, 189, 243) font:[UIFont systemFontOfSize:18] target:self action:@selector(cancelBtn:)];
    [self.contentView addSubview:cancelBtn];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    
    // 确认按钮
    UIButton * sureButton = [FYInitUIItem buttonWithFrame:CGRectMake(cancelBtn.width+1, cancelBtn.y, cancelBtn.width, 40) title:@"确定" titleColor:RGB(49, 189, 243) font:[UIFont systemFontOfSize:18] target:self action:@selector(ensureBtn:)];
    [self.contentView addSubview:sureButton];
    [sureButton setBackgroundColor:[UIColor whiteColor]];
}

- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

- (void)ensureBtn:(UIButton *)sender{
    if (self.fyAlertBtnClick) {
        self.fyAlertBtnClick(FY_ClickAlertBtnTypeEnsure);
    }
    [self dismiss];
}

- (void)cancelBtn:(UIButton *)sender{
    if (self.fyAlertBtnClick) {
        self.fyAlertBtnClick(FY_ClickAlertBtnTypeCancel);
    }
    [self dismiss];
}

#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}
-(UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font
{
    UITextField *_rechargeTextField = [[UITextField alloc]initWithFrame:frame];
    _rechargeTextField.placeholder = [NSString stringWithFormat:@"    %@",placeholder];
    _rechargeTextField.font = font;
    [_rechargeTextField setValue:[NSNumber numberWithInt:16] forKey:@"paddingLeft"];

    UIView *line = [FYInitUIItem viewWithFrame:CGRectMake(20, frame.size.height-1, frame.size.width-20-10, 1) backgroundColor:RGB(230, 230, 230)];
    [_rechargeTextField addSubview:line];
    
    return _rechargeTextField;
}
@end
