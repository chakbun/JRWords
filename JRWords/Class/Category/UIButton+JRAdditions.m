//
//  UIButton+JRAdditions.m
//  JRWords
//
//  Created by Jaben on 14-10-18.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "UIButton+JRAdditions.h"

@implementation UIButton (JRAdditions)

- (void)setTitleInNormalState:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

@end
