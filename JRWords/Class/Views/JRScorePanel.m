//
//  JRScorePanel.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRScorePanel.h"

@interface JRScorePanel ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *scoreLabel;

@end

@implementation JRScorePanel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [self createLabel4ScorePanel];
        _titleLabel.width = self.width/3.0;
        _titleLabel.text = @"Score: ";
        
        _scoreLabel = [self createLabel4ScorePanel];
        _scoreLabel.left = _titleLabel.right;
        _scoreLabel.width = self.width - _titleLabel.width;
        _scoreLabel.adjustsFontSizeToFitWidth = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        _scoreLabel.userInteractionEnabled = YES;
        [_scoreLabel addGestureRecognizer:tapGesture];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_titleLabel];
        [self addSubview:_scoreLabel];
    }
    return self;
}

#pragma mark --Public
- (void)setTotalScore:(NSInteger)totalScore {
    _totalScore = totalScore;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",(int)_totalScore];
}

#pragma mark --Misc
- (void)tapAction:(UIGestureRecognizer *)recognizer {
    if (_hintActionBlock) {
        _hintActionBlock();
    }
}

- (UILabel *)createLabel4ScorePanel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
@end
