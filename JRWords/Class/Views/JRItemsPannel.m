//
//  JRItemsPannel.m
//  JRWords
//
//  Created by Jaben on 14-10-18.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRItemsPannel.h"
#import "UIButton+JRAdditions.h"

@implementation JRItemsPannel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setLettersSource:(NSArray *)lettersSource {
    _lettersSource = lettersSource;
    
    CGFloat itemSpacing;
    CGFloat itemWidth; // 5 * itemSpace;
    CGFloat itemTop = 5;
    
    itemSpacing = self.width / (6 * lettersSource.count + 1);
    itemWidth = 5 * itemSpacing;
    
    for(int i = 0; i < lettersSource.count; i++) {
        
        CGRect sourceButtonRect = CGRectMake(itemSpacing*(i+1)+itemWidth*i, itemTop, itemWidth, itemWidth);
        UIButton *sourceButton = [self createLetterButtonWithFrame:sourceButtonRect type:0];
        [sourceButton setTitleInNormalState:lettersSource[i]];
        
        CGRect selectedButtonRect = sourceButtonRect;
        selectedButtonRect.origin.y = sourceButton.bottom + itemTop * 2;
        UIButton *selectedButton = [self createLetterButtonWithFrame:selectedButtonRect type:1];
        
        [self addSubview:sourceButton];
        [self addSubview:selectedButton];
    }
}

- (UIButton *)createLetterButtonWithFrame:(CGRect)rect type:(NSInteger)type{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    
    UIColor *buttonBackgroundColor = (type == 0)?[UIColor blackColor]:[UIColor lightGrayColor];
    [button setBackgroundColor:buttonBackgroundColor];
    
    return button;
}
@end
