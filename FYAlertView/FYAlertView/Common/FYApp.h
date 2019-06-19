//
//  FYApp.h
//  特治单车
//
//  Created by 冯宇的Mac mini on 2019/6/11.
//  Copyright © 2019 冯宇的Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,DeviceType) {
    IPhone_X = 0,
    Unknown,
    Simulator,
    IPhone_1G,          //基本不用
    IPhone_3G,          //基本不用
    IPhone_3GS,         //基本不用
    IPhone_4,           //基本不用
    IPhone_4s,          //基本不用
    IPhone_5,
    IPhone_5C,
    IPhone_5S,
    IPhone_SE,
    IPhone_6,
    IPhone_6P,
    IPhone_6s,
    IPhone_6s_P,
    IPhone_7,
    IPhone_7P,
    IPhone_8,
    IPhone_8P,
    //    IPhone_X,
};
@interface FYApp : NSObject

+(BOOL)isiPhoneXScreen;

@end

NS_ASSUME_NONNULL_END
