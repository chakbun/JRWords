//
//  OTThirdPartyManager.m
//  oneTouchX5
//
//  Created by Jaben on 14-7-24.
//  Copyright (c) 2014年 xpg. All rights reserved.
//

#import "OTThirdPartyManager.h"
#import <Social/Social.h>

//// Weibo
#define kAppKeyWeibo         @"3887830599"
#define kAppSecretWeibo      @"562c05d56e3f1eddb63fda0d07b2210d"
#define kRedirectURIWeibo    @"https://api.weibo.com/oauth2/default.html"

//// Wechat
#define kAppIdWeixin         @"wxaaddba76ae544455"
#define kAppSecretWeixin     @"34ad830562db424f7e0d02a69418b5df"
#define kRedirectURIWeixin   @""

//// Tecent
#define kAppIdTencent        @"1102309542"
#define kAppKeyTencent       @"vqCkZ09eXQu06FBJ"
#define kRedirectURITecent   @"www.qq.com"

static TencentOAuth *oauth;

@implementation OTThirdPartyManager
+ (instancetype)shareManager {
    static OTThirdPartyManager *_shareManager;
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        
        _shareManager = [[OTThirdPartyManager alloc] init];
        
        [WXApi registerApp:kAppIdWeixin];
        [WeiboSDK registerApp:kAppKeyWeibo];
        oauth = [[TencentOAuth alloc] initWithAppId:kAppIdTencent andDelegate:(id<TencentSessionDelegate>)self];
        oauth.redirectURI = kRedirectURITecent;
    });
    return _shareManager;
}

//////////////
#pragma mark -- Public
//////////////////////

- (void)authorizeByLoginType:(OTLoginType)loginType {
    switch (loginType) {
        case OTLoginTypeWeibo:{
            if([WeiboSDK isWeiboAppInstalled]){
                [self authorizeByWeibo];
            }else {
                [UIAlertView showOKAlertWithMessage:@"请先安装新浪微博客户端"];
            }
            break;
        }
        case OTLoginTypeTencent:{
            if([TencentOAuth iphoneQQInstalled]) {
                [self authorizeByTencent];
            }else {
                [UIAlertView showOKAlertWithMessage:@"请先安装QQ客户端"];
            }
        }
            break;
        case OTLoginTypeWechat:
            if([WXApi isWXAppInstalled]) {
                [self authorizeByWechat];
            }else {
                [UIAlertView showOKAlertWithMessage:@"请先安装微信客户端"];
            }
            break;
        default:
            break;
    }
}

- (void)shareToType:(OTShareType)shareType text:(NSString *)text image:(UIImage *)image controller:(UIViewController *)controller {
    switch (shareType) {
        case OTShareTypeSinaWeibo:
            [self useIOSIntergationToShare:SLServiceTypeSinaWeibo WithImage:image text:text controller:controller];
            break;
        case OTShareTypeTencentWeibo:
            [self useIOSIntergationToShare:SLServiceTypeTencentWeibo WithImage:image text:text controller:controller];
            break;
        case OTShareTypeQQ:{
            [self shareToTencentWithImage:image];
            break;
        }
        case OTShareTypeQQZone:{
            [self shareToTencentWithImage:image];
            break;
        }
        case OTShareTypeWechat:{
            [self shareToWechatWithImage:image scene:WXSceneSession];
            break;
        }
        case OTShareTypeWechatTimeline:{
            [self shareToWechatWithImage:image scene:WXSceneTimeline];
            break;
        }
        default:
            break;
    }
}

#pragma mark --Pricate

/////////////
// SHARE With IOS6 integration
////////////////////////////

- (void)useIOSIntergationToShare:(NSString *)type WithImage:(UIImage *)image text:(NSString *)text controller:(UIViewController *)controller{
    if ([SLComposeViewController isAvailableForServiceType:type]) {
        SLComposeViewController *socialController = [SLComposeViewController composeViewControllerForServiceType:type];
        [socialController setInitialText:text];
        [socialController addImage:image];
        [controller presentViewController:socialController animated:YES completion:^{
            
        }];
    }else {
        [UIAlertView showOKAlertWithMessage:@"请在系统设置登录分享的账号再进行分享"];
    }
}

/////////////
// SHARE TO Tencent
////////////////////////////

- (void)shareToTencentWithImage:(UIImage *)image {
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:UIImageJPEGRepresentation(image, 0.3)
                                               previewImageData:UIImageJPEGRepresentation(image, 0.1)
                                                          title:@""
                                                    description:@""];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    [QQApiInterface sendReq:req];
}

/////////////
// SHARE TO Wechat
////////////////////////////

- (void)shareToWechatWithImage:(UIImage *)image scene:(int)scene{
    if([WXApi isWXAppInstalled]) {
        WXMediaMessage *mediaMsg = [WXMediaMessage message];
        mediaMsg.title = @"OneTouch Share";
        NSData *data = UIImageJPEGRepresentation([image zipImageWithSize:CGSizeMake(100, 100)], 0.3);
        mediaMsg.thumbData = data;
        
        WXImageObject *imageObj = [WXImageObject object];
        imageObj.imageData = UIImageJPEGRepresentation(image, 0.3);
        mediaMsg.mediaObject = imageObj;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = mediaMsg;
        req.scene = scene;
        [WXApi sendReq:req];
    }else {
        [UIAlertView showOKAlertWithMessage:@"请先安装微信客户端再进行分享"];
    }
}

/////////////
#pragma mark -- SinaWeibo Delegate
///////////////////////////////////

- (void)authorizeByWeibo {
    [WeiboSDK enableDebugMode:YES];
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURIWeibo;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    OTLog(@"============weibo didReceiveWeiboRequest============");
    OTLog(@"WEIBO request: %@",request);
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    OTLog(@"============weibo didReceiveWeiboResponse============");
    OTLog(@"WEIBO response info: %@ statusCode:%d",response.requestUserInfo,response.statusCode);
}

//////////////////
#pragma mark --Wechat Delegate && Tecent Delegate
/////////////////////////////////////////////////

- (void)authorizeByWechat {
    SendAuthReq *req = [[SendAuthReq alloc ] init];
    // permission:get user info 
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    [WXApi sendReq:req];
}

- (void)onReq:(id)req {
    OTLog(@"============Wechat didReceiveRequest============");
    if([req isKindOfClass:[QQBaseReq class]]) {
//        QQBaseReq *qqRequest = (QQBaseReq *)req;
//        OTLog(@"TECENT request type: %d accessToken:%@",qqRequest.type,oauth.accessToken);
    }else if([req isKindOfClass:[SendAuthReq class]]) {
        SendAuthReq *wechatRequest = (SendAuthReq *)req;
        OTLog(@"Wechat request type: %d",wechatRequest.type);
    }
}

- (void)onResp:(id)resp {
    OTLog(@"============Wechat didReceiveRequest============");
    if([resp isKindOfClass:[QQBaseResp class]]) {
//        QQBaseResp *qqResponse = (QQBaseResp *)resp;
//        OTLog(@"TECENT request reult: %@ accessToken:%@",qqResponse.result,oauth.accessToken);
    }else if([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *wechatResponse = (SendAuthResp *)resp;
        OTLog(@"Wechat request code: %@",wechatResponse.code);
    }
}

////////////////
#pragma mark --Tencent Delegate
///////////////////////////////////

- (void)authorizeByTencent {
    NSArray *permission = @[@"get_user_info",@"add_share"];
    [oauth authorize:permission inSafari:NO];
}
- (void)tencentDidLogin {
    OTLog(@"accessToken:%@",oauth.accessToken);
}

- (void)tencentDidNotLogin:(BOOL)cancelled {}
- (void)tencentDidNotNetWork {}
- (void)isOnlineResponse:(NSDictionary *)response{}
@end
