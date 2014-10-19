//
//  NSArray+JRAdditions.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "NSArray+JRAdditions.h"

@implementation NSArray (JRAdditions)

- (NSString *)lettersToWord {
    NSMutableString *words = [NSMutableString string];
    for(NSString *letter in self) {
        [words appendString:letter];
    }
    return words;
}

- (instancetype)randomSorted {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self];
    NSInteger count = self.count;
    while (--count > 0) {
        int randomIndex = arc4random() % count;
        [tempArray exchangeObjectAtIndex:count withObjectAtIndex:randomIndex];
    }
    return tempArray;
}

@end
