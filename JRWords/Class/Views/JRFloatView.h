//
//  JRFloatView.h
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRFloatView : UIView
@property (nonatomic, assign) NSInteger totalScore;

@property (nonatomic, strong) void(^rankActionBlock)(id sender);
@property (nonatomic, strong) void(^shareActionBlock)(id sender);
@property (nonatomic, strong) void(^restartActionBlock)(id sender);

- (void)showView:(BOOL)show;
@end
