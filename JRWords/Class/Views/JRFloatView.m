//
//  JRFloatView.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRFloatView.h"
#import "UIButton+JRAdditions.h"

@interface JRFloatView ()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *restartButton;
@property (nonatomic, strong) UIButton *rankingButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *scoreLabel;
@end

@implementation JRFloatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(10, (self.height - 250)/2.0, self.width-20, 250)];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _contentView.width, 40)];
        _scoreLabel.backgroundColor = [UIColor clearColor];
        _scoreLabel.font = [UIFont systemFontOfSize:20];
        _scoreLabel.adjustsFontSizeToFitWidth = YES;
        
        CGRect buttonRect = CGRectMake(0, 0, 40, 40);
        
        _rankingButton = [self createLetterButtonWithFrame:buttonRect];
        [_rankingButton setTitleInNormalState:@"Rank"];
        _rankingButton.top = _scoreLabel.bottom;
        
        _restartButton = [self createLetterButtonWithFrame:buttonRect];
        [_restartButton setTitleInNormalState:@"Restart"];
        _restartButton.top = _rankingButton.top;
        _restartButton.left = _rankingButton.right+10;
        
        _shareButton = [self createLetterButtonWithFrame:buttonRect];
        [_shareButton setTitleInNormalState:@"Share"];
        _shareButton.top = _rankingButton.top;
        _shareButton.left = _restartButton.right+10;

        [_contentView addSubview:_scoreLabel];
        [_contentView addSubview:_rankingButton];
        [_contentView addSubview:_restartButton];
        [_contentView addSubview:_shareButton];
        
        [self addSubview:_contentView];
    }
    return self;
}

#pragma mark --Misc

- (void)setTotalScore:(NSInteger)totalScore {
    _totalScore = totalScore;
    _scoreLabel.text = [NSString stringWithFormat:@"Total Score: %d",_totalScore];
}

- (UIButton *)createLetterButtonWithFrame:(CGRect)rect {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = rect.size.width/5.0;
    button.backgroundColor = [UIColor blackColor];
    return button;
    
}
@end
