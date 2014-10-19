//
//  JRDictionaryManager.h
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRDictionaryManager : NSObject

+ (instancetype)shareManager;

- (NSString *)searchWordsSourceWithWord:(NSString *)word;
- (NSDictionary *)getDictionary;

@end
