//
//  NSDictionary+JRAdditions.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "NSDictionary+JRAdditions.h"
#define RandomNumberTo(upper) (arc4random() % (upper))

@implementation NSDictionary (JRAdditions)

- (NSString *)randomKey {
    NSArray *keys = [self allKeys];
    return keys[RandomNumberTo(keys.count)];
}

@end
