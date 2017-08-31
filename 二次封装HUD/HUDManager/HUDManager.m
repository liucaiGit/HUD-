//
//  HUDManager.m
//  二次封装HUD
//
//  Created by liucai on 2017/8/28.
//  Copyright © 2017年 liucai. All rights reserved.
//

#import "HUDManager.h"
#import "MBProgressHUD.h"

/**
 *
 MBProgressHUDModeIndeterminate                 小菊花(UIActivityIndicatorView)
 MBProgressHUDModeDeterminate                   扇形进度条(round, pie-chart like)
 MBProgressHUDModeDeterminateHorizontalBar      水平的进度条(Horizontal progress bar)
 MBProgressHUDModeAnnularDeterminate            圆环(ring-shaped progress view)
 MBProgressHUDModeCustomView                    自定义(custom view)
 MBProgressHUDModeText                          仅文字(only labels)
*/

static HUDManager *instance = nil;

@interface HUDManager ()

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic,strong)UIWindow *keyWindow;

@end

@implementation HUDManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil] init];
    });
    return instance;
}

- (void)showSuccessMessage:(NSString *)successMessage {
    //自定义样式
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success@2x.png"]];
    self.HUD.minShowTime = 2.f;
    
    self.HUD.detailsLabelText = successMessage.length > 10 ? successMessage : @"";
    self.HUD.labelText = successMessage.length > 10 ? @"" : successMessage;
    
    [self.HUD show:YES];
    [self.HUD hide:YES];
    
    [self.keyWindow bringSubviewToFront:self.HUD];
}

- (void)showErrorMessage:(NSString *)errorMessage {
    //自定义样式
    self.HUD.mode = MBProgressHUDModeCustomView;
    self.HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error@2x.png"]];
    self.HUD.minShowTime = 2.f;
    
    self.HUD.detailsLabelText = errorMessage.length > 10 ? errorMessage : @"";
    self.HUD.labelText = errorMessage.length > 10 ? @"" : errorMessage;
    
    [self.HUD show:YES];
    [self.HUD hide:YES];
    
    [self.keyWindow bringSubviewToFront:self.HUD];
}

//需手动隐藏
- (void)showLoadding:(NSString *)text {
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    
    self.HUD.detailsLabelText = text.length > 10 ? text : @"";
    self.HUD.labelText = text.length > 10 ? @"" : text;
    
    [self.HUD show:YES];
    
    [self.keyWindow bringSubviewToFront:self.HUD];
}


- (void)hiddenLoadding {
    [self.HUD hide:YES];
}

- (void)showHUD:(NSString *)title detail:(NSString *)detail {
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.minShowTime = 2.f;
    
    self.HUD.labelText = title;
    self.HUD.detailsLabelText = detail;
    
    [self.HUD show:YES];
    [self.HUD hide:YES];
    
    [self.keyWindow bringSubviewToFront:self.HUD];
}


#pragma mark - 懒加载
- (MBProgressHUD *)HUD {
    if (!_HUD) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        _HUD = [[MBProgressHUD alloc] initWithWindow:keyWindow];
        
        [keyWindow addSubview:_HUD];
        
        //配置属性
        _HUD.labelFont = [UIFont systemFontOfSize:16.f];
        _HUD.detailsLabelFont = [UIFont systemFontOfSize:14.f];
        _HUD.activityIndicatorColor = [UIColor whiteColor];
        _HUD.userInteractionEnabled = NO;
    }
    return _HUD;
}

- (UIWindow *)keyWindow {
    if (!_keyWindow) {
        /**
         *  此处为何不使用[[UIApplication sharedApplication] keyWindow]  AppDelegate中window属性若不自定义 使用上述语句得到的window为nil  且就算自定义不要轻易使用 正常情况下没任何区别 当APP跳转至相册相机或者其他APP返回本App时  视图的frame会发生一些位移
         */
        _keyWindow = [[[UIApplication sharedApplication] delegate] window];
    }
    return _keyWindow;
}

@end
