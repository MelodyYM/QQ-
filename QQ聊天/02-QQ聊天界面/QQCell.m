//
//  AppDelegate.h
//  02-QQ聊天界面
//
//  Created by apple on
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "QQCell.h"
#import "QQFrameModel.h"
#import "QQModel.h"

@interface QQCell()

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UIImageView *userImageView;

@property (nonatomic, weak) UIButton *contentButton;

@end


@implementation QQCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 初始化子控件
        [self setupUI];
    }
    return self;
}


#pragma mark -
#pragma mark -  初始化子控件
- (void)setupUI {
    // 时间
    UILabel *timeLable = [[UILabel alloc] init];
    self.timeLabel = timeLable;
    
    // 居中显示
    timeLable.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:timeLable];

    // 用户头像
    UIImageView *userImageView = [[UIImageView alloc] init];
    self.userImageView = userImageView;
    
    [self.contentView addSubview:userImageView];
    
    // 文本buton
    UIButton *contentButton = [[UIButton alloc] init];
    self.contentButton = contentButton;
    
    // 设置文本颜色
    [contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 设置文本自动换行
    contentButton.titleLabel.numberOfLines = 0;
    
    // 设置文本的font
    contentButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置背景颜色
//    [contentButton setBackgroundColor:[UIColor orangeColor]];
    
    // 设置button的内边距， 让内容的显示距离button边界有一段距离
    contentButton.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    
    
    [self.contentView addSubview:contentButton];
}


#pragma mark -
#pragma mark -  重写frameModel的set方法
- (void)setFrameModel:(QQFrameModel *)frameModel {
    _frameModel = frameModel;
    
    // 设置数据
    [self setupData];
    
    // 设置frame
    [self setupFrame];
}

#pragma mark -
#pragma mark -  设置数据
- (void)setupData {
    QQModel *model = _frameModel.qqModel;
    
    // 设置时间
    _timeLabel.text = model.time;
    
    // 决定timeLabel 是否要隐藏
    _timeLabel.hidden = model.isHidenTimeLabel;
    
    
    // 设置头像
    // 判断是我， 还是其他人, 设置背景图片
    if (model.type == QQUserTypeMe) { // 表示自己
        // 用户头像
        _userImageView.image = [UIImage imageNamed:@"me"];
        
        // 拉伸图片
        UIImage *resizeImage = [self resizeImageWith:@"chat_send_nor"];
        
        // 背景图片
//        [_contentButton setBackgroundImage:[UIImage imageNamed:@"chat_send_nor"] forState:UIControlStateNormal];
        [_contentButton setBackgroundImage:resizeImage forState:UIControlStateNormal];
        
    } else { // 表示别人
        
        // 用户头像
        _userImageView.image = [UIImage imageNamed:@"other"];
        
        // 背景图片
        // 拉伸图片
        UIImage *resizeImage = [self resizeImageWith:@"chat_recive_press_pic"];
        
        [_contentButton setBackgroundImage:resizeImage forState:UIControlStateNormal];
        
//        [_contentButton setBackgroundImage:[UIImage imageNamed:@"chat_recive_press_pic"] forState:UIControlStateNormal];
    }
    
    // 设置文本
    [_contentButton setTitle:model.text forState:UIControlStateNormal];
    
    
}

/**
 抽取方法的时候
 相同的代码拿出来放到一个方法里
 不同的代码转为参数
 
 */
- (UIImage *)resizeImageWith:(NSString *)imageName {
    // 对图片进行处理
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 计算image 宽高的一半
    CGFloat halfWidth = image.size.width/2;
    CGFloat halfHeight = image.size.height/2;
    
    // CapInsets : 距离图片四周的距离
    /**
     UIImageResizingModeTile,  平铺
     UIImageResizingModeStretch, 拉伸
     */
    UIImage *resizeImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth) resizingMode:UIImageResizingModeStretch];
    
    // 把拉伸过之后的image 反回
    return resizeImage;
}


#pragma mark -
#pragma mark -  设置frame
- (void)setupFrame {
    
    // 时间frame
    _timeLabel.frame = _frameModel.timeLabelFrame;
    
    // 用户头像frame
    _userImageView.frame = _frameModel.iconFrame;
    
    // 文本frame
    _contentButton.frame = _frameModel.textFrame;
    
}

@end
