//
//  JRMainController.m
//  JRWords
//
//  Created by Jaben on 14-10-18.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRMainController.h"
#import "JRItemsPannel.h"
#import "JRScorePanel.h"
#import "JRTipsPannel.h"
#import "NSDictionary+JRAdditions.h"
#import "UIAlertView+Blocks.h"

@interface JRMainController ()
@property (nonatomic, strong) JRItemsPannel *itemsPannel;
@property (nonatomic, strong) JRTipsPannel *tipsPannel;
@property (nonatomic, strong) JRScorePanel *scorePannel;
@end

@implementation JRMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scorePannel = [[JRScorePanel alloc] initWithFrame:CGRectMake(self.view.width/2.0, 10, self.view.width/2.0, 50)];
    _scorePannel.left = _scorePannel.left - 40;
    _scorePannel.totalScore = 0;
    [self.view addSubview:_scorePannel];
    
    _itemsPannel =  [[JRItemsPannel alloc] initWithFrame:CGRectMake(0, _scorePannel.bottom+5, self.view.width, 200)];
    [self loadWordToItemPannel];
    
    __weak __typeof(self) weakSelf = self;
    [_itemsPannel setCompletedBlock:^BOOL(NSString *combinedWord) {
        NSString *valueOfWord = [[JRDictionaryManager shareManager] searchWordsSourceWithWord:combinedWord];
        if (valueOfWord) {
            // success;
            [weakSelf addScoreToPannelWithRightAnswer:YES];
            [weakSelf showChineseMessageInPannel:valueOfWord];
            [weakSelf.tipsPannel showNextButton:YES];
        }else {
            [weakSelf addScoreToPannelWithRightAnswer:NO];
        }
        return valueOfWord != nil;
    }];
    
    [self.view addSubview:_itemsPannel];
    
    _tipsPannel = [[JRTipsPannel alloc] initWithFrame:CGRectMake(0, _itemsPannel.bottom+5, self.view.width, 100)];
    _tipsPannel.tipInChinese = @"开始";
    [_tipsPannel setNextButtonActionBlock:^(id sender) {
        [weakSelf loadWordToItemPannel];
    }];
    [self.view addSubview:_tipsPannel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --Misc

- (void)addScoreToPannelWithRightAnswer:(BOOL)right {
    NSInteger adding = right?5:-5;
    _scorePannel.totalScore = _scorePannel.totalScore + adding;
}

- (void)showChineseMessageInPannel:(NSString *)tipInChinese {
    _tipsPannel.tipInChinese = tipInChinese;
}

- (void)loadWordToItemPannel {
    NSDictionary *wordsSource = [[JRDictionaryManager shareManager] getDictionary];
    NSString *randomWord = [wordsSource randomKey];
    _itemsPannel.lettersSource = [[randomWord wordToLetters] randomSorted];
}
@end
