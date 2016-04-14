//
//  AppDelegate.h
//  02-QQ聊天界面
//
//  Created by apple on
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "QQModel.h"
#import "QQFrameModel.h"
#import "QQCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark -
#pragma mark -  懒加载数据
- (NSMutableArray *)dataArray {
    if (nil == _dataArray) {
        
        // 先实例化 _dataArray
        _dataArray = [NSMutableArray array];
        
        // 路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        
        // 读取内容
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        
        // 转模型
        for (NSDictionary *dict in tempArray) {
            QQModel *qqModel = [QQModel qqModelWithDict:dict];
            
            // 先取出上一条数据, 数组中最后一条
            QQFrameModel *lastFrameModel = _dataArray.lastObject;
            
            if ([qqModel.time isEqualToString:lastFrameModel.qqModel.time]) {
                // 如果时间相等， 那么就把 现在的qqModel 对象的 hidenTimeLbel = YES
                qqModel.hidenTimeLabel = YES;
            }
            
            // 赋值给 frameModel进行计算
            QQFrameModel *frameModel = [[QQFrameModel alloc] init];
            frameModel.qqModel = qqModel;
            
            [_dataArray addObject:frameModel];
        }
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置控制器成为tableView的数据源代理
    _tableView.dataSource = self;
    
    // 设置控制器成为tableView的代理
    _tableView.delegate = self;
    
    // 每一个cell的高度都是相同
//    _tableView.rowHeight = 60;
    
    
    // 设置 textField 的代理为  控制器
    _textField.delegate = self;
    
    // 滚动到最后一行
    [self scrollToBottom];
    
    
    [self registerNotification];
}

#pragma mark -
#pragma mark -  添加对键盘的监听
- (void)registerNotification {
    // 添加了一个 键盘即将显示时的监听， 如果接收到通知， 将调用 keyboardWillApprear：
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillApprear:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    
    
    // 添加监听，  键盘即将隐藏的时候， 调用
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisAppear:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    /**
     [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(keyboardWillApprear:)
                                                  name:UIKeyboardWillChangeFrameNotification
                                                object:nil];
     */
    
}


- (void)keyboardChange:(NSNotification *)noti{
    NSDictionary *dict = noti.userInfo;
    if (_tableView.contentOffset.y == 625) {
        // 取出通知中的信息
        NSDictionary *dict = noti.userInfo;
        
        // 间隔时间
        NSTimeInterval interval = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        // 键盘的高度
        // 停止后的Y值
        CGRect keyboardRect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        CGFloat keyboardEndY = keyboardRect.origin.y;
        
        // 没出现时的Y值
        CGRect tempRect = [dict[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
        
        CGFloat keyboardBeginY = tempRect.origin.y;
        
        // 对 tableView  执行动画， 向上平移
        
        [UIView animateWithDuration:interval animations:^{
            
            self.view.transform = CGAffineTransformMakeTranslation(0, (keyboardEndY - keyboardBeginY));
        }];

    }else{
        // 取出通知中的信息
       // NSDictionary *dict = noti.userInfo;
        
        // 间隔时间
        NSTimeInterval interval = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [UIView animateWithDuration:interval animations:^{
            
            // CGAffineTransformIdentity 恢复 transform的设置
            self.view.transform = CGAffineTransformIdentity;
        }];

    
    }
    
    
}




#pragma mark -
#pragma mark -  键盘即将显示的时候调用

- (void)keyboardWillApprear:(NSNotification *)noti {
    
    
    /**
     UIKeyboardAnimationCurveUserInfoKey = 7;   动画的频率
     UIKeyboardAnimationDurationUserInfoKey = "0.25";  动画时间
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";  键盘的宽高
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}"; 没弹出的时候的位置
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";  弹出键盘之后的位置
     UIKeyboardIsLocalUserInfoKey = 1;

     */
    
    
    // 取出通知中的信息
    NSDictionary *dict = noti.userInfo;
    
    // 间隔时间
    NSTimeInterval interval = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的高度
    // 停止后的Y值
    CGRect keyboardRect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardEndY = keyboardRect.origin.y;
    
    // 没出现时的Y值
    CGRect tempRect = [dict[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    CGFloat keyboardBeginY = tempRect.origin.y;
    
    // 对 tableView  执行动画， 向上平移
    
    [UIView animateWithDuration:interval animations:^{
       
        self.view.transform = CGAffineTransformMakeTranslation(0, (keyboardEndY - keyboardBeginY));
    }];
}

#pragma mark -
#pragma mark -  键盘即将隐藏的时候调用
- (void)keyboardWillDisAppear:(NSNotification *)noti {
    // 取出通知中的信息
    NSDictionary *dict = noti.userInfo;
    
    // 间隔时间
    NSTimeInterval interval = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:interval animations:^{
        
        // CGAffineTransformIdentity 恢复 transform的设置
        self.view.transform = CGAffineTransformIdentity;
    }];
    
}

#pragma mark -
#pragma mark -  当用户拖动tableview的时候， 把键盘回退
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 撤销textField 的第一响应者身份
    [_textField resignFirstResponder];
}


// 组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 行

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// 内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 定义重用标识符
    static NSString *identifier = @"QQ";
    
    // 到缓存池中去找
    QQCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // 判断
    if (nil == cell) {
        cell = [[QQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        // 选中cell后不改变颜色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // 把frameModel 传递给cell， 因为frameModel中， 包含了cell中要显示子控件的frame 和 数据
    QQFrameModel *frameModel = self.dataArray[indexPath.row];
    
    cell.frameModel = frameModel;
    
    return cell;
}

#pragma mark -
#pragma mark -  返回每一行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     tableView 加载的时候， 会先调用这个方法， 数据有多少个就调用多少次
     每一次调用 cellForRowAtIndexPath: 会再一次调用 heightForRowAtIndexPath
     */
    
    QQFrameModel *frameModel = self.dataArray[indexPath.row];
    
    return frameModel.cellHeight;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark -
#pragma mark -  textField的代理方法
// 当点击键盘右下角的return按钮的时候就会调用这个方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // 撤销 ， textField 的第一响应者身份
    [textField resignFirstResponder];

    /**
     发送自己的消息 
     1. 发送消息的内容
     2. 谁发送的
     */
    [self sendMessageWith:textField.text andType:QQUserTypeMe];
    
    // 发送对方的消息
    [self sendMessageWith:@"小逗逼" andType:QQUserTypeOther];
    
    
    // 清空textField 中的数据
    _textField.text = @"";
   
    return YES;
}

#pragma mark -
#pragma mark -  发送消息时调用的方法
- (void)sendMessageWith:(NSString *)message andType:(QQUserType)type {
    
    // 防止输入空字符
    if (message.length == 0) {
        
        return;
    }
    
    // 添加一条新的消息
    QQModel *qqModel = [[QQModel alloc] init];
    
    // 时间
    // qqModel.time = @"4:50";
    
    // 取出当前的时间
    NSDate *currentDate = [NSDate date];
    
    // 设置时间的格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 时间格式
    // yyyy-MM-dd HH:mm:ss  时间格式
    formatter.dateFormat = @"HH:mm";
    
    NSString *dateString = [formatter stringFromDate:currentDate];
    
    
    // 赋值 给 qqModel 的time
    qqModel.time = dateString;
    
    // 内容
    qqModel.text = message;
    
    // 消息发送者的身份
    qqModel.type = type;
    
    
    // 做判断， 如果时间一致要把当前qqModel 中的 hidenTimeLabel ＝ YES
    QQFrameModel *lastFrameModel = self.dataArray.lastObject;
    
    if ([lastFrameModel.qqModel.time isEqualToString:qqModel.time]) {
        // 设置隐藏属性
        qqModel.hidenTimeLabel = YES;
    }
    
    
    
    // 把qqModel 赋值给  qqFrameModel ，要根据内容计算控件的frame以及cell的高度
    QQFrameModel *frameModel = [[QQFrameModel alloc] init];
    frameModel.qqModel = qqModel;
    
    
    // 添加到数组中
    [self.dataArray addObject:frameModel];
    
    // 刷新数据
    //    [_tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
    
    [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];

    
    // 滚动到最后一行
    //    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self scrollToBottom];
}


#pragma mark -
#pragma mark -  滚动到最后一行的方法
- (void)scrollToBottom {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0];
    
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}


#warning 一定不要忘记移除监听者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
