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
@property (nonatomic, strong) UILabel *scoreTitleLabel;
@end

@implementation JRFloatView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 60, self.width-20, 300)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.borderColor = [[UIColor whiteColor] CGColor];
        _contentView.layer.borderWidth = 1.0;
        _contentView.layer.cornerRadius = _contentView.width/25.0;
        
        _scoreTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _contentView.width, 40)];
        _scoreTitleLabel.backgroundColor = [UIColor clearColor];
        _scoreTitleLabel.font = [UIFont systemFontOfSize:20];
        _scoreTitleLabel.adjustsFontSizeToFitWidth = YES;
        _scoreTitleLabel.textAlignment = NSTextAlignmentCenter;
        _scoreTitleLabel.text = @"Your Score: ";
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _scoreTitleLabel.bottom, _contentView.width, 80)];
        _scoreLabel.backgroundColor = [UIColor clearColor];
        _scoreLabel.font = [UIFont systemFontOfSize:69];
        _scoreLabel.adjustsFontSizeToFitWidth = YES;
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        
        CGRect buttonRect = CGRectMake(0, 0, 70, 70);
        
//        _rankingButton = [self createLetterButtonWithFrame:buttonRect];
//        [_rankingButton setTitleInNormalState:@"Rank"];
//        _rankingButton.top = _scoreLabel.bottom;
//        _rankingButton.left = 22;
//        [_restartButton addTarget:self action:@selector(restartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _restartButton = [self createLetterButtonWithFrame:buttonRect];
        [_restartButton setTitleInNormalState:@"Restart"];
        _restartButton.top = _scoreLabel.bottom+20;
        _restartButton.left = 40;
        [_restartButton addTarget:self action:@selector(restartButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _shareButton = [self createLetterButtonWithFrame:buttonRect];
        [_shareButton setTitleInNormalState:@"Share"];
        _shareButton.top = _restartButton.top;
        _shareButton.right = _contentView.width - _restartButton.left;
        [_shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];

        [_contentView addSubview:_scoreLabel];
        [_contentView addSubview:_scoreTitleLabel];
        [_contentView addSubview:_restartButton];
        [_contentView addSubview:_shareButton];
        
        [self addSubview:_contentView];
        self.alpha = 0.f;
    }
    return self;
}

#pragma mark --Show / Hidden View

- (void)showView:(BOOL)show {
    if (show) {
        [UIView animateWithDuration:1.0 animations:^{
            _contentView.top = 60;
            self.alpha = 1.f;
        } completion:^(BOOL finished) {}];
    }else {
        [UIView animateWithDuration:1.0 animations:^{
            _contentView.top = self.bottom;
            self.alpha = 0.f;
        } completion:^(BOOL finished) {}];
    }
}


#pragma mark --Button Action

- (void)restartButtonAction:(id)sender {
    [self showView:NO];
    if (_restartActionBlock) {
        _restartActionBlock(sender);
    }
}

- (void)shareButtonAction:(id)sender {
    if (_shareActionBlock) {
        _shareActionBlock(sender);
    }
}

- (void)rankButtonAction:(id)sender {
    if (_rankActionBlock) {
        _rankActionBlock(sender);
    }
}

#pragma mark --Misc

- (void)tapGesture:(UIGestureRecognizer *)gestureRecognizer {
}

- (void)setTotalScore:(NSInteger)totalScore {
    _totalScore = totalScore;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",_totalScore];
}

- (UIButton *)createLetterButtonWithFrame:(CGRect)rect {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = rect.size.width/2.0;
    button.backgroundColor = [UIColor blackColor];
    return button;
    
}
@end
