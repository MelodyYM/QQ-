//
//  AppDelegate.h
//  02-QQ聊天界面
//
//  Created by apple on
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 typedef NS_ENUM(内部的值类型,QQUserType(枚举的名称)) {
 QQUserTypeOther = 1,
 QQUserTypeMe
 };
 */

typedef NS_ENUM(NSInteger,QQUserType) {
    QQUserTypeOther,
    QQUserTypeMe
};

@interface QQModel : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) QQUserType type;

// 记录cell中的 timeLabel 是否要隐藏掉
// isHidenTimeLabel 就是这么写
@property (nonatomic , assign,getter=isHidenTimeLabel) BOOL hidenTimeLabel;

- (instancetype)initWithDict:(NSDictionary *)dict;


+ (instancetype)qqModelWithDict:(NSDictionary *)dict;


@end
