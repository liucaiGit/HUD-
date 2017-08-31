//
//  HUDViewController.m
//  二次封装HUD
//
//  Created by liucai on 2017/8/29.
//  Copyright © 2017年 liucai. All rights reserved.
//

#import "HUDViewController.h"
#import "HUDManager.h"

#define kScreen_width [UIScreen mainScreen].bounds.size.width
#define kScreen_height [UIScreen mainScreen].bounds.size.height

@interface HUDViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy)NSArray *dataSource;

@end

@implementation HUDViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createImageV];
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //自定义成功
        [[HUDManager sharedManager] showSuccessMessage:@"加载成功"];
    }
    if (indexPath.row == 1) {
        //自定义失败
        [[HUDManager sharedManager] showErrorMessage:@"加载失败"];
    }if (indexPath.row == 2) {
        //仅小菊花
        [[HUDManager sharedManager] showLoadding:@""];
        
        [self performSelector:@selector(hiddenLoadding) withObject:nil afterDelay:2.f];
        
    }else if (indexPath.row == 3) {
        //小菊花 + 文字
        [[HUDManager sharedManager] showLoadding:@"小菊花+文字"];
        
         [self performSelector:@selector(hiddenLoadding) withObject:nil afterDelay:2.f];
    }else if (indexPath.row == 4) {
        //文字
        [[HUDManager sharedManager] showHUD:@"标题" detail:@"详情详情详情"];
    }
}

- (void)hiddenLoadding {
    [[HUDManager sharedManager] hiddenLoadding];
}

#pragma mark - Initilization
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"自定义成功",@"自定义失败",@"仅小菊花",@"小菊花+文字",@"文字+detail"];
    }
    return _dataSource;
}

- (void)createImageV {
    //图片url‘
    NSString *imageStr = @"https://image.baidu.com/search/detail?ct=503316480&z=0&ipn=false&word=头像&step_word=&hs=0&pn=7&spn=0&di=102393177260&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&istype=2&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=-1&cs=2028944957%2C1175359310&os=241281591%2C1522662234&simid=4220319732%2C686914906&adpicid=0&lpn=0&ln=3930&fr=&fmq=1461834053046_R&fm=&ic=0&s=0&se=&sme=&tab=0&width=&height=&face=undefined&ist=&jit=&cg=head&bdtype=0&oriquery=&objurl=http%3A%2F%2Fwww.qq745.com%2Fuploads%2Fallimg%2F141227%2F1-14122H11147.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bqq09c_z%26e3Bv54AzdH3Fgwgfijg2AzdH3Fm8l8_z%26e3Bip4s&gsm=0&rpstart=0&rpnum=0";
    
    __block UIImageView *centerImageV;
    centerImageV = [[UIImageView alloc] init];
    centerImageV.frame = CGRectMake(0, 0, 100, 100);
//    centerImageV.backgroundColor = [UIColor greenColor];
    centerImageV.center = self.view.center;
    
    [self.view addSubview:centerImageV];
    
    //异步下载图片
    __block UIImage *originalImage;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imageStr]] returningResponse:nil error:nil];
        //下载完成后回到主线程进行操作
        dispatch_async(dispatch_get_main_queue(), ^{
            
            originalImage = [UIImage imageWithData:imageData];
            centerImageV.image = originalImage;
        });
    });
}

@end
