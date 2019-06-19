//
//  FYInitUIItem.h
//  特治单车
//
//  Created by 冯宇的Mac mini on 2019/6/11.
//  Copyright © 2019 冯宇的Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FYInitUIItem : NSObject
+(UIButton *)buttonWithFrame:(CGRect)frame
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor
                        font:(UIFont *)font
                      target:(nullable id)target
                      action:(SEL)action;

+(UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

+(UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image;

+(UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

+(UITableView *)tableViewWithFrame:(CGRect)frame
                             style:(UITableViewStyle)style
                    separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
                          delegate:(id)target;

+(UIView *)noDataViewWithImage:(UIImage *)image title:(NSString *)title;


+(UIScrollView *)bgScrollView;

//项目对应TextField样式
+(UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font;

//获取屏幕截图
+(UIImage *)screenImageWithSize:(CGSize)imgSize;

//设置圆角
+(void)setCornerRadius:(CGFloat)radius forView:(UIView *)v;

//设置边框
+(void)setBorderWidth:(CGFloat)borderWidth
          borderColor:(UIColor *)borderColor
              forView:(UIView *)v;
@end

NS_ASSUME_NONNULL_END
