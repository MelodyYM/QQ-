//
//  AppDelegate.h
//  02-QQ聊天界面
//
//  Created by apple on
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQFrameModel;

@interface QQCell : UITableViewCell

@property (nonatomic, strong) QQFrameModel *frameModel;

@end
