//
//  DefineUtil.h
//  JabenUtil
//
//  Created by Jaben on 14-3-1.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#ifndef JabenUtil_DefineUtil_h
#define JabenUtil_DefineUtil_h

#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
#define deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define kScreenBounds                   [UIScreen mainScreen] bounds]
#define kAppWidth                       [[UIScreen mainScreen] bounds].size.width
#define kAppHeight                      [[UIScreen mainScreen] bounds].size.height

#define kTabItemHeight                  44.0
#define kStatusHeight                   20.0

#define kUserNameRegex                  @"^[A-Za-z0-9_]{3,18}(@([a-zA-Z0-9_-])+(\\.[a-zA-Z0-9_-]+)){0,1}$"
#define kPasswordRegex                  @".{6,12}"
#define kPhoneNumberRegex               @"^(0|\\+86|86){0,1}(13[0-9]|15[0-9]|18[6-9])[0-9]{8}$"

#define __toString(x) __toString_0(x)
#define __toString_0(x) #x
#define LOG_MACRO(x) NSLog(@"%s=\n%s", #x, __toString(x))

#ifdef DEBUG
#define DeLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DeLog(...)
#endif

//String
#define string(s,...) [NSString stringWithFormat:(s), ##__VA_ARGS__]

//消息
#define AddNotifObserver(_selector,_name) ([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil])
#define RemoveNotifObserver(_name) ([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])
#define PostNotif(_name) ([[NSNotificationCenter defaultCenter] postNotificationName:_name object:nil userInfo:nil])
#define PostNotifWithObj(_name,_obj) ([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:nil])
#define PostNotifWithObjAndUserInfo(_name,_obj,_infos) ([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:_infos])

//文件操作
#define FileDefaultManager [NSFileManager defaultManager]
#define BoundlePath [[NSBundle mainBundle] resourcePath]
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]//沙盒资源目录

#endif
