//
//  JRItemsPannel.m
//  JRWords
//
//  Created by Jaben on 14-10-18.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRItemsPannel.h"
#import "UIButton+JRAdditions.h"

#define kTagSourceButtonBase 10
#define kTagSelectedButtonBase 20
#define IntegerToString(number) [NSString stringWithFormat:@"%d",number]

@interface JRItemsPannel ()
@property (nonatomic, strong) NSMutableArray *selectedLetters;
@property (nonatomic, strong) NSMutableDictionary *buttonsMapping;
@end

@implementation JRItemsPannel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _selectedLetters = [[NSMutableArray alloc] init];
        _buttonsMapping = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setLettersSource:(NSArray *)lettersSource {
    
    for(UIView *subview in [self subviews]) {
        if([subview isKindOfClass:[UIButton class]]) {
            [subview removeFromSuperview];
        }
    }
    [_selectedLetters removeAllObjects];
    [_buttonsMapping removeAllObjects];
    
    _lettersSource = lettersSource;
    
    CGFloat itemSpacing;
    CGFloat itemWidth; // 5 * itemSpace;
    CGFloat itemTop = 5;
    
    itemSpacing = self.width / (6 * lettersSource.count + 1);
    itemWidth = 5 * itemSpacing;
    
    for(int i = 0; i < lettersSource.count; i++) {
        
        CGRect sourceButtonRect = CGRectMake(itemSpacing*(i+1)+itemWidth*i, itemTop, itemWidth, itemWidth);
        UIButton *sourceButton = [self createLetterButtonWithFrame:sourceButtonRect type:0];
        sourceButton.tag = kTagSourceButtonBase+i;
        sourceButton.titleLabel.font = [UIFont systemFontOfSize:40];
        sourceButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [sourceButton setTitleInNormalState:lettersSource[i]];
        
        CGRect selectedButtonRect = sourceButtonRect;
        selectedButtonRect.origin.y = sourceButton.bottom + itemTop * 2;
        UIButton *selectedButton = [self createLetterButtonWithFrame:selectedButtonRect type:1];
        selectedButton.tag = kTagSelectedButtonBase+i;
        selectedButton.titleLabel.font = [UIFont systemFontOfSize:40];
        selectedButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        selectedButton.enabled = NO;
        [self addSubview:sourceButton];
        [self addSubview:selectedButton];
    }
}

- (UIButton *)createLetterButtonWithFrame:(CGRect)rect type:(NSInteger)type{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = rect.size.width/5.0;
    
    
    UIColor *buttonBackgroundColor = (type == 0)?[UIColor blackColor]:[UIColor clearColor];
    
    SEL buttonAction = (type == 0)?@selector(sourceButtonAction:):@selector(selectedButtonAction:);
    [button addTarget:self action:buttonAction forControlEvents:UIControlEventTouchUpInside];
    
    [button setBackgroundColor:buttonBackgroundColor];
    
    return button;

}

#pragma mark --Misc



#pragma mark --ButtonAction

- (void)sourceButtonAction:(id)sender {
    
    UIButton *sourceButton = sender;
    sourceButton.hidden = YES;
    
    UIButton *firstAvailableButton =(UIButton *)[self viewWithTag:(kTagSelectedButtonBase + _selectedLetters.count)];
    NSString *letter = _lettersSource[(sourceButton.tag - kTagSourceButtonBase)];
    [_selectedLetters addObject:letter];
    [firstAvailableButton setTitleInNormalState:letter];
    firstAvailableButton.backgroundColor = [UIColor blackColor];
    firstAvailableButton.enabled = YES;
    
    [_buttonsMapping setObject:@(sourceButton.tag) forKey:IntegerToString(firstAvailableButton.tag)];
    
    /*
     let the previous button disable, if the button is exist;
     */
    if (firstAvailableButton.tag > kTagSelectedButtonBase) {
        UIButton *previousButton = (UIButton *)[self viewWithTag:firstAvailableButton.tag-1];
        previousButton.enabled = NO;
    }
    
    if (_selectedLetters.count == _lettersSource.count) {
        if (_completedBlock) {
            if(_completedBlock([_selectedLetters lettersToWord])) {
                // success, disable all selected Button
                UIButton *lastButton = (UIButton *)[self viewWithTag:(kTagSelectedButtonBase+_selectedLetters.count-1)];
                lastButton.enabled = NO;
            };
        }
    }
}

- (void)selectedButtonAction:(id)sender {
    
    UIButton *selectedButton = sender;
    selectedButton.backgroundColor = [UIColor clearColor];
    [selectedButton setTitleInNormalState:@""];
    
    UIButton *sourceButton = (UIButton *)[self viewWithTag:[[_buttonsMapping objectForKey:IntegerToString(selectedButton.tag)] intValue]];
    sourceButton.hidden = NO;
    [_selectedLetters removeLastObject];
    
    /*
     let the previous button enbale, if the button is exist;
     */
    
    if (selectedButton.tag > kTagSelectedButtonBase) {
        UIButton *previousButton = (UIButton *)[self viewWithTag:selectedButton.tag-1];
        previousButton.enabled = YES;
    }
}


@end
