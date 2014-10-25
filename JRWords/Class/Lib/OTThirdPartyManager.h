//
//  OTThirdPartyManager.h
//  oneTouchX5
//
//  Created by Jaben on 14-7-24.
//  Copyright (c) 2014年 xpg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"


typedef NS_ENUM(NSInteger, OTShareType) {
    OTShareTypeQQZone = 0,
    OTShareTypeSinaWeibo ,
    OTShareTypeTencentWeibo,
    OTShareTypeQQ,
    OTShareTypeWechat,
    OTShareTypeWechatTimeline,
};

typedef NS_ENUM(NSInteger, OTLoginType) {
    OTLoginTypeWeibo = 0,
    OTLoginTypeTencent,
    OTLoginTypeWechat,
};

@interface OTThirdPartyManager : NSObject<WeiboSDKDelegate,WXApiDelegate,QQApiInterfaceDelegate,TencentSessionDelegate>
+ (instancetype)shareManager;
- (void)authorizeByLoginType:(OTLoginType)loginType;
- (void)shareToType:(OTShareType)shareType text:(NSString *)text image:(UIImage *)image controller:(UIViewController *)controller;
@end
