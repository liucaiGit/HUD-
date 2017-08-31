//
//  HUDManager.h
//  二次封装HUD
//
//  Created by liucai on 2017/8/28.
//  Copyright © 2017年 liucai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUDManager : NSObject

/**
 *  单例实现
 */
+ (instancetype)sharedManager;

/**
 *  显示成功
 */
- (void)showSuccessMessage:(NSString *)successMessage;

/**
 *  显示失败
 */
- (void)showErrorMessage:(NSString *)errorMessage;


/**
 *  隐藏菊花HUD
 */
- (void)hiddenLoadding;

/**
 *  加载中......小菊花 + 文字
 */
- (void)showLoadding:(NSString *)text;

/**
 *  显示detail
    @param title  HUD标题
    @param detail HUD副标题
 */
- (void)showHUD:(NSString *)title detail:(NSString *)detail;

@end
