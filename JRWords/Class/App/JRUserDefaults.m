//
//  JRUserDefaults.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRUserDefaults.h"

NSString *const kRanking = @"kRanking";

@implementation JRUserDefaults

+ (instancetype)shareManager {
    static JRUserDefaults *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager =[[JRUserDefaults alloc] init];
    });
    return shareManager;
}

- (NSArray *)getRangking {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kRanking];
}

- (void)refreshRaning:(NSInteger)score {
    NSMutableArray *currentRanking = [NSMutableArray arrayWithArray:[self getRangking]];
    [currentRanking addObject:@(score)];
    NSArray *newRanking = [currentRanking sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 intValue] < [obj2 intValue];
    }];
    currentRanking = [NSMutableArray arrayWithArray:newRanking];
    if(currentRanking.count > 3) {
        [currentRanking removeLastObject];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:currentRanking forKey:kRanking];
}
@end
