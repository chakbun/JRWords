//
//  NSString+JRAdditions.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "NSString+JRAdditions.h"

@implementation NSString (JRAdditions)

- (NSArray *)wordToLetters {
    NSMutableArray *letters = [NSMutableArray array];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [letters addObject:substring];
    }];
    return letters;
}
@end
