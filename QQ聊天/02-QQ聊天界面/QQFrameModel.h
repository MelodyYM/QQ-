//
//
//  AppDelegate.h
//  02-QQ聊天界面
//
//  Created by apple on
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class QQModel;

@interface QQFrameModel : NSObject

@property (nonatomic, assign) CGRect timeLabelFrame;

@property (nonatomic, assign) CGRect iconFrame;

@property (nonatomic, assign) CGRect textFrame;


@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, strong) QQModel *qqModel;

@end
