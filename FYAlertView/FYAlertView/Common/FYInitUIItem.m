//
//  FYInitUIItem.m
//  特治单车
//
//  Created by 冯宇的Mac mini on 2019/6/11.
//  Copyright © 2019 冯宇的Mac mini. All rights reserved.
//
#define kWidth [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height
#define SafeAreaTopHeight ([FYApp isiPhoneXScreen] ? 88 : 64)
#import "FYInitUIItem.h"
#import "UIColor+FYColor.h"
#import "UIView+FYFrame.h"
#import "AppDelegate.h"
#import "FYApp.h"
@implementation FYInitUIItem
+(UIButton *)buttonWithFrame:(CGRect)frame
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor
                        font:(UIFont *)font
                      target:(nullable id)target
                      action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UITableView *)tableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle delegate:(id)target
{
    UITableView *tbView = [[UITableView alloc]initWithFrame:frame style:style];
    tbView.tableFooterView = [UIView new];
    tbView.delegate = target;
    tbView.dataSource = target;
    tbView.separatorStyle = separatorStyle;
    tbView.backgroundColor = [UIColor colorWithHexString:@"#F8F7FD"];
    return tbView;
}

+(UIView *)viewWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    UIView *v = [[UIView alloc]initWithFrame:frame];
    v.backgroundColor = backgroundColor;
    return v;
}

+(UIImageView *)imageViewWithFrame:(CGRect)frame image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = image;
    imageView.userInteractionEnabled = YES;
    return imageView;
}

+(UILabel *)labelWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = titleColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = font;
    return label;
}

+(UIView *)noDataViewWithImage:(UIImage *)image title:(NSString *)title
{
    UIView *_noDataBgView = [self viewWithFrame:CGRectMake(0, 0, kWidth, 147+46) backgroundColor:[UIColor clearColor]];
    _noDataBgView.y = kHeight*0.5;
    
    UIImageView *imageV = [self imageViewWithFrame:CGRectMake(0, 0, 150, 147) image:image];
    imageV.x = kWidth*0.5;
    [_noDataBgView addSubview:imageV];
    
    UILabel *tLabel = [self labelWithFrame:CGRectMake(0, 147+26, kWidth, 20) title:title titleColor:[UIColor colorWithHexString:@"#999999"] font:[UIFont systemFontOfSize:14]];
    [_noDataBgView addSubview:tLabel];
    
    return _noDataBgView;
}


+(UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font
{
    UITextField *_rechargeTextField = [[UITextField alloc]initWithFrame:frame];
//    _rechargeTextField.borderStyle = UITextBorderStyleNone;
//    _rechargeTextField.layer.borderColor= [UIColor colorWithHexString:@"#C3CBD1"].CGColor;
    _rechargeTextField.keyboardType = UIKeyboardTypeDecimalPad;
//    _rechargeTextField.layer.borderWidth = 0.5f;
//    _rechargeTextField.layer.cornerRadius = 3;
    _rechargeTextField.placeholder = [NSString stringWithFormat:@"    %@",placeholder];
    _rechargeTextField.font = font;
    [_rechargeTextField setValue:[NSNumber numberWithInt:16] forKey:@"paddingLeft"];
    
    UIView *line = [self viewWithFrame:CGRectMake(20, frame.size.height-1, frame.size.width-20-10, 1) backgroundColor:RGB(230, 230, 230)];
    [_rechargeTextField addSubview:line];
    
    return _rechargeTextField;
}

+(UIScrollView *)bgScrollView
{
    UIScrollView *_bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kWidth, kHeight-SafeAreaTopHeight)];
    _bgScrollView.backgroundColor = [UIColor colorWithHexString:@"#F8F7FD"];
    if (@available(iOS 11.0, *)) {
        _bgScrollView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    }
    //    _bgScrollView.contentSize = CGSizeMake(0, kheight-SafeAreaTopHeight);
    return _bgScrollView;
}

+(UIImage *)screenImageWithSize:(CGSize)imgSize
{
    UIGraphicsBeginImageContextWithOptions(imgSize, TRUE, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate; //获取app的appdelegate，便于取到当前的window用来截屏
    [app.window.layer renderInContext:context];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners
                          forView:(UIView *)v
{
    
    //    UIRectCorner type = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    
    //1. 加一个layer 显示形状
    CGRect rect = CGRectMake(borderWidth/2.0, borderWidth/2.0,
                             CGRectGetWidth(v.frame)-borderWidth, CGRectGetHeight(v.frame)-borderWidth);
    CGSize radii = CGSizeMake(cornerRadius, borderWidth);
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [v.layer addSublayer:shapeLayer];
    
    
    
    
    //2. 加一个layer 按形状 把外面的减去
    CGRect clipRect = CGRectMake(0, 0,
                                 CGRectGetWidth(v.frame)-1, CGRectGetHeight(v.frame)-1);
    CGSize clipRadii = CGSizeMake(cornerRadius, borderWidth);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:clipRect byRoundingCorners:corners cornerRadii:clipRadii];
    
    CAShapeLayer *clipLayer = [CAShapeLayer layer];
    clipLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    clipLayer.lineWidth = 1;
    clipLayer.lineJoin = kCALineJoinRound;
    clipLayer.lineCap = kCALineCapRound;
    clipLayer.path = clipPath.CGPath;
    
    v.layer.mask = clipLayer;
}

+(void)setCornerRadius:(CGFloat)radius forView:(UIView *)v
{
    v.layer.masksToBounds = YES;
    v.layer.cornerRadius = radius;
}

+(void)setBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor forView:(UIView *)v
{
    v.layer.masksToBounds = YES;
    v.layer.borderColor = borderColor.CGColor;
    v.layer.borderWidth = borderWidth;
}

//+(void)refreshControlForTableView:(UITableView *)tableView
//                 refreshingTarget:(id)target
//           headerRefreshingAction:(SEL)action1
//           footerRefreshingAction:(SEL)action2
//{
//    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingTarget:target refreshingAction:@selector(action2)];
//    tableView.mj_footer = footer;
//    
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:@selector(action1)];
//    tableView.mj_header = header;
//}
@end
