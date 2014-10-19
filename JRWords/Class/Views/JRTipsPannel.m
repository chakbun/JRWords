//
//  JRTipsPannel.m
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRTipsPannel.h"
#import "UIButton+JRAdditions.h"

@interface JRTipsPannel ()
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *nextButton;
@end

@implementation JRTipsPannel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/2.0)];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:25];
        _tipLabel.adjustsFontSizeToFitWidth = YES;
        
        _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(20, _tipLabel.bottom+10, self.width-40, 50)];
        _nextButton.backgroundColor = [UIColor blackColor];
        [_nextButton setTitleInNormalState:@"Next->"];
        [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 15;
        _nextButton.layer.borderWidth = 1.0;
        _nextButton.layer.borderColor = [[UIColor blackColor] CGColor];
        _nextButton.hidden = YES;
        
        [self addSubview:_tipLabel];
        [self addSubview:_nextButton];
    }
    return self;
}

- (void)setTipInChinese:(NSString *)tipInChinese {
    _tipInChinese = tipInChinese;
    _tipLabel.text = _tipInChinese;
}

#pragma mark --Button Action

- (void)nextButtonAction:(id)sender {
    _nextButton.hidden = YES;
    _tipLabel.text = @"";
    if (_nextButtonActionBlock) {
        _nextButtonActionBlock(sender);
    }
}

#pragma mark --Public
- (void)showNextButton:(BOOL)show {
    _nextButton.hidden = !show;
}

@end
