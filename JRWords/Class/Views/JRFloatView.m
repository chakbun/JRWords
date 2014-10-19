//
//  JRFloatView.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRFloatView.h"

@interface JRFloatView ()
@property (nonatomic, strong) UIView *contentView;

@end

@implementation JRFloatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return self;
}

@end
