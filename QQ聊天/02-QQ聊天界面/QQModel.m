//
//  AppDelegate.h
//  02-QQ聊天界面
//
//  Created by apple on
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "QQModel.h"

@implementation QQModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        
        // kvc 如果字典里的值类型和 属性中的不同， 就会做自动转换
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)qqModelWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
