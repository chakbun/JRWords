//
//  JRDictionaryManager.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRDictionaryManager.h"
#define kNameWordsSourcePlist @"JRWordsSource"

@implementation JRDictionaryManager

+ (instancetype)shareManager {
    static JRDictionaryManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager =[[JRDictionaryManager alloc] init];
    });
    return shareManager;
}

#pragma mark --Public Method

- (NSString *)searchWordsSourceWithWord:(NSString *)word {
    return [self getValueFromPlistFile:kNameWordsSourcePlist key:word];
}

- (NSDictionary *)getDictionary {
    NSString *path = [[NSBundle mainBundle] pathForResource:kNameWordsSourcePlist ofType:@"plist"];
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    return plistDictionary;
}


#pragma mark --Plist I/O Method

- (NSString *)getValueFromPlistFile:(NSString *)fileName key:(NSString *)key4Value {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    if (plistDictionary) {
        NSString *value4Key = plistDictionary[key4Value];
        return value4Key;
    }
    
    return nil;
}
@end
