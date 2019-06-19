//
//  FYAlertView.h
//  FYtest
//
//  Created by 冯宇的Mac mini on 2019/6/18.
//  Copyright © 2019 冯宇的Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ClickAlertBtnType){
    FY_ClickAlertBtnTypeCancel,
    FY_ClickAlertBtnTypeEnsure
};
NS_ASSUME_NONNULL_BEGIN

@interface FYAlertView : UIView



@property(nonatomic, copy) void (^fyAlertBtnClick)(ClickAlertBtnType type);

- (instancetype)initWithTittle:(NSString *)tittle placeholder:(NSString *)placeholder target:(id)target tfKeyboardType:(UIKeyboardType)keyboardType block:(void (^) (ClickAlertBtnType type))block;

- (void)show;
@end

NS_ASSUME_NONNULL_END
