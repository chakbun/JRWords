//
//  JRUserDefaults.h
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRUserDefaults : NSObject
+ (instancetype)shareManager;

- (NSArray *)getRangking;
- (void)refreshRaning:(NSInteger)score;
@end
