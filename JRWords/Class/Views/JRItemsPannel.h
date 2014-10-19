//
//  JRItemsPannel.h
//  JRWords
//
//  Created by Jaben on 14-10-18.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRItemsPannel : UIView
@property (nonatomic, strong) NSArray *lettersSource;
@property (nonatomic, strong) BOOL (^completedBlock)(NSString *combinedWord);
@end
