//
//  AppDelegate.h
//  02-QQ聊天界面
//
//  Created by apple on
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "QQFrameModel.h"
#import "QQModel.h"

// 屏幕的宽高
#define kScreenSize ([UIScreen mainScreen].bounds.size)

#define kDeltaMargin 40

@implementation QQFrameModel


- (void)setQqModel:(QQModel *)qqModel {
    
    _qqModel = qqModel;
    
    // 计算frame
    // 计算时间label
    CGFloat timeLabelX = 0;
    CGFloat timeLabelY = 0;
    CGFloat timeLabelWidht = kScreenSize.width;
    CGFloat timeLabeHeight = 20;
    
    _timeLabelFrame = CGRectMake(timeLabelX, timeLabelY, timeLabelWidht, timeLabeHeight);
    
    
    // 用户头像
    CGFloat margin = 10;
    CGFloat iconX = margin;
    CGFloat iconY = CGRectGetMaxY(_timeLabelFrame) + margin;
    CGFloat iconWidht = 40;
    CGFloat iconHeight = 40;
    
    // 做判断是显示到左侧(other)还是右侧(自己)
    
    if (qqModel.type == 1) { // 表示自己
        CGFloat rightIconX = kScreenSize.width - margin - iconWidht;
        
        _iconFrame = CGRectMake(rightIconX, iconY, iconWidht, iconHeight);
        
    } else {
        
        _iconFrame = CGRectMake(iconX, iconY, iconWidht, iconHeight);
    }
    
    
    // 文本的frame
    // 计算text能显示的最大的宽度
    CGFloat maxWidth = kScreenSize.width - 2 * iconWidht - 4 * margin;
    
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    // 根据文本计算 真实的size
    CGSize textRealSize = [qqModel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    CGFloat textX = CGRectGetMaxX(_iconFrame) + margin;
    CGFloat textY = iconY;
    CGFloat textWidth = textRealSize.width;
    CGFloat textHeight = textRealSize.height;
    
    if (qqModel.type == QQUserTypeMe) { // 表示自己
        
        CGFloat rightTextX = kScreenSize.width - textWidth - iconWidht - margin - kDeltaMargin - margin;
        
        _textFrame = CGRectMake(rightTextX, textY, textWidth, textHeight);
        
        
    } else {
        
        _textFrame = CGRectMake(textX, textY, textWidth, textHeight);
    }
    
    // 增加button的宽高
    _textFrame.size.width += kDeltaMargin;
    _textFrame.size.height += kDeltaMargin;

    
    // cell 的高度
    _cellHeight = CGRectGetMaxY(_textFrame) + margin;
}


@end
