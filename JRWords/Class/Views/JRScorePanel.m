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
@property (nonatomic, strong) UILabel *chanceLabel;
@property (nonatomic, strong) UILabel *chanceTitleLabel;

@end

@implementation JRScorePanel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [self createLabel4ScorePanel];
        _titleLabel.left = 10;
        _titleLabel.width = 60;
        _titleLabel.text = @"Score: ";
        
        _scoreLabel = [self createLabel4ScorePanel];
        _scoreLabel.left = _titleLabel.right;
        _scoreLabel.width = self.width/2.0-_titleLabel.width;
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
        _scoreLabel.adjustsFontSizeToFitWidth = YES;
        _scoreLabel.backgroundColor = [UIColor clearColor];
        
        
        [self addSubview:_titleLabel];
        [self addSubview:_scoreLabel];
        
        _chanceTitleLabel = [self createLabel4ScorePanel];
        _chanceTitleLabel.width = 80;
        _chanceTitleLabel.left = _scoreLabel.right;
        _chanceTitleLabel.text = @"Chances: ";
        _chanceTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        _chanceLabel = [self createLabel4ScorePanel];
        _chanceLabel.left = _chanceTitleLabel.right;
        _chanceLabel.width = self.width/2.0-_chanceTitleLabel.width;
        _chanceLabel.textAlignment = NSTextAlignmentLeft;
        _chanceLabel.text = @"";
        
        self.backgroundColor = [UIColor clearColor];

        [self addSubview:_chanceTitleLabel];
        [self addSubview:_chanceLabel];
    }
    return self;
}

#pragma mark --Public

- (void)setTotalScore:(NSInteger)totalScore {
    _totalScore = totalScore;
    _scoreLabel.text = [NSString stringWithFormat:@"%d",(int)_totalScore];
}

- (void)setRemainChances:(NSInteger)remainChances {
    _remainChances = remainChances;
    _chanceLabel.text = [NSString stringWithFormat:@"%d",(int)_remainChances];
}

#pragma mark --Misc

- (UILabel *)createLabel4ScorePanel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
@end
