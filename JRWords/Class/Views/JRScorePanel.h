//
//  JRScorePanel.h
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRScorePanel : UIView
@property (nonatomic, assign) NSInteger totalScore;
@property (nonatomic, assign) NSInteger remainChances;
@property (nonatomic, strong) void (^hintActionBlock)();
@end
