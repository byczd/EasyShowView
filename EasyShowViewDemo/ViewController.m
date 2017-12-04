//
//  ViewController.m
//  EasyShowViewDemo
//
//  Created by nf on 2017/11/24.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "ViewController.h"
#import "EasyShowView.h"
#import "EasyShowView+Loding.h"
#import "EasyShowView+Text.h"
#import "EasyShowView+Alert.h"
#import "EasyShowOptions.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView ;
@property (nonatomic,strong)NSArray *dataArray ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"父视图接受事件" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
}

- (void)rightBarClick
{
    EasyShowOptions *options = [EasyShowOptions sharedEasyShowOptions];
    options.superViewReceiveEvent = !options.superViewReceiveEvent ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10 ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            [self showTextWithRow:indexPath.row] ;
            break;
        case 1:
            [self showLodingWithRow:indexPath.row];
            break ;
        case 2:
            [self showAlertWithRow:indexPath.row];
            break ;
        default:
            break;
    }
}

- (void)showTextWithRow:(long)row
{
    switch (row) {
        case 0:{
            static int aa = 0 ;
            [EasyShowOptions sharedEasyShowOptions].textStatusType = (++aa)%3 ;
            [EasyShowView showText:@"今天发的拉伸发送；了解来看四大皆空了试大家了"];
        } break;
        case 1:{
            [EasyShowOptions sharedEasyShowOptions].textStatusType = ShowStatusTextTypeStatusBar ;
            [EasyShowView showText:@"今天发的拉伸发大家了"];
        } break ;
        case 2:
        {
            
        }break ;
        case 3:{
            static int bb = 0 ;
            switch (bb++%4) {
                case 0:  [EasyShowView showSuccessText:@"恭喜您通过所有关卡!"];  break;
                case 1:  [EasyShowView showErrorText:@"加载失败！"];  break ;
                case 2:  [EasyShowView showInfoText:@"请完善信息！"];  break ;
                case 3:  [EasyShowView showImageText:@"自定义图片" image:[UIImage imageNamed:@"HUD_NF.png"]];  break ;
                default: break;
            }
        } break ;
    }
}
- (void)showLodingWithRow:(long)row
{
    static int b_0 = 0 ;
    switch (row) {
        case 0:
            [EasyShowOptions sharedEasyShowOptions].showLodingType = ++b_0%2 ? ShowLodingTypeLeftDefault : ShowLodingTypeDefault ;
            [EasyShowView showLodingText:@"默认加载中..."];
            break;
        case 1:
            [EasyShowOptions sharedEasyShowOptions].showLodingType = ++b_0%2 ? ShowLodingTypeLeftIndicator : ShowLodingTypeIndicator ;
            [EasyShowView showLodingText:@"菊花加载中..."];
            break ;
        case 2:
            [EasyShowOptions sharedEasyShowOptions].showLodingType = ++b_0%2 ? ShowLodingTypeLeftImage : ShowLodingTypeImage ;
            [EasyShowView showLodingText:@"正在加载中,请稍后..." image:[UIImage imageNamed:@"HUD_NF.png"]];
            break ;
        case 3:
            [EasyShowView hidenLoding];
            break ;
        default:
            break;
    }
}
- (void)showAlertWithRow:(long)row
{
    switch (row) {
        case 0:
            //                    [EasyShowView showAlertWithTitle:@"提示" desc:@"发送开机发送开机" buttonArray:@[@"取消",@"确定",@"您好",@"确定",@"您好"] callBack:nil];
            break;
        case 1:
        {
            //                    __block NSArray *titleArray = @[@"确定",@"取消",@"点击迪桑阿牛"] ;
            //                    [EasyShowView showAlertSystemWithTitle:@"提示" desc:@"这是提示先的副标题(可以为空)" buttonArray:titleArray callBack:^(NSUInteger index) {
            //                        NSLog(@"%zd----  %@",index ,titleArray[index]);
            //                    }];
        }break;
        default:
        {
            EasyShowView *showAlet = [EasyShowView showActionSheetWithTitle:@"提示" message:@"这是提示的副标题"] ;
            [showAlet addItemWithTitle:@"确定" image:[UIImage imageNamed:@"HUD_NF.png"] itemType:9 callback:^(EasyShowView *showView, NSUInteger index) {
                NSLog(@"dddd");
            }];
            [showAlet addItemWithTitle:@"" image:nil itemType:ShowAlertItemTypeRed callback:^(EasyShowView *showView, NSUInteger index) {
                NSLog(@"read") ;
            }];
            
            [showAlet show];
        }break ;
            
    }
}


#pragma mark - getter/setter
- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        _tableView.dataSource = self ;
        _tableView.delegate = self ;
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        img.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView =img ;
    }
    return _tableView ;
}

- (NSArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = @[
                       @[@"纯文字(上中下)",@"纯文字(statusbar上)",@"纯文字（navigation上）",@"显示成功/失败/提示/图片"],
                       @[@"默认加载框",@"菊花加载框",@"图片加载框",@"隐藏加载框"] ,
                       @[@"展示alertView",@"展示系统alertView"]
                       ];
    }
    return _dataArray ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
