//
//  JRTipsPannel.h
//  JRWords
//
//  Created by Jaben on 14-10-19.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRTipsPannel : UIView
@property (nonatomic, strong) NSString *tipInChinese;
@property (nonatomic, strong) void(^nextButtonActionBlock)(id sender);

- (void)showNextButton:(BOOL)show;
@end
