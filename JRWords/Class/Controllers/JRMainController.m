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
#import "iToast.h"
#import "JRUserDefaults.h"
#import "JRFloatView.h"

@interface JRMainController ()
@property (nonatomic, strong) JRItemsPannel *itemsPannel;
@property (nonatomic, strong) JRTipsPannel *tipsPannel;
@property (nonatomic, strong) JRScorePanel *scorePannel;
@property (nonatomic, strong) NSString *currentWord;
@property (nonatomic, strong) JRFloatView *floatView;
@property (nonatomic, strong) NSMutableArray *answerChance;
@end

@implementation JRMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
    self.view.backgroundColor = [UIColor whiteColor];
    __weak __typeof(self) weakSelf = self;

    _answerChance = [[NSMutableArray alloc] init];

    _scorePannel = [[JRScorePanel alloc] initWithFrame:CGRectMake(self.view.width/2.0, 10, self.view.width/2.0, 50)];
    _scorePannel.left = _scorePannel.left - 40;
    _scorePannel.totalScore = 0;
    [_scorePannel setHintActionBlock:^{
        if (weakSelf.scorePannel.totalScore >= 30) {
            NSString *valueOfWord = [[JRDictionaryManager shareManager] searchWordsSourceWithWord:weakSelf.currentWord];
            if (valueOfWord) {
                [[iToast makeText:valueOfWord] show];
                [weakSelf removeScoreByUsingHins];
            }else {
                [[iToast makeText:@"no hints, i am sorry"] show];
            }
        }else {
            [[iToast makeText:@"sorry"] show];
        }
    }];
    
    [self.view addSubview:_scorePannel];
    
    _itemsPannel =  [[JRItemsPannel alloc] initWithFrame:CGRectMake(0, _scorePannel.bottom+5, self.view.width, 200)];
    
    [_itemsPannel setCompletedBlock:^BOOL(NSString *combinedWord) {
        NSString *valueOfWord = [[JRDictionaryManager shareManager] searchWordsSourceWithWord:combinedWord];
        if (valueOfWord) {
            // success;
            [weakSelf addScoreToPannelWithRightAnswer:YES];
            [weakSelf.tipsPannel showNextButton:YES];
        }else {
            [weakSelf.answerChance addObject:@(-1)];
            if (weakSelf.answerChance.count > 3) {
                    // game over;
                    [weakSelf.answerChance removeAllObjects];
                    weakSelf.floatView.totalScore = weakSelf.scorePannel.totalScore;
                    [weakSelf.floatView showView:YES];
            }
        }
        return valueOfWord != nil;
    }];
    
    [self.view addSubview:_itemsPannel];
    
    _tipsPannel = [[JRTipsPannel alloc] initWithFrame:CGRectMake(0, _itemsPannel.bottom+5, self.view.width, 100)];
    _tipsPannel.tipInChinese = @"";
    [_tipsPannel setNextButtonActionBlock:^(id sender) {
        [weakSelf loadWordToItemPannel];
    }];
    [self.view addSubview:_tipsPannel];
    
    _floatView = [[JRFloatView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    
    [_floatView setRestartActionBlock:^(id sender) {
        weakSelf.scorePannel.totalScore = 0;
        [weakSelf loadWordToItemPannel];
    }];
    
    [_floatView setShareActionBlock:^(id sender) {
        
    }];
    
    [_floatView setRankActionBlock:^(id sender) {
        
    }];
    
    [_floatView showView:NO];
    [self.view addSubview:_floatView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadWordToItemPannel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --Misc

- (void)addScoreToPannelWithRightAnswer:(BOOL)right {
    NSInteger adding = right?5:-5;
    _scorePannel.totalScore = _scorePannel.totalScore + adding;
}

- (void)removeScoreByUsingHins {
    _scorePannel.totalScore = _scorePannel.totalScore -30;
}

- (void)showChineseMessageInPannel:(NSString *)tipInChinese {
    _tipsPannel.tipInChinese = tipInChinese;
}

- (void)loadWordToItemPannel {
    NSDictionary *wordsSource = [[JRDictionaryManager shareManager] getDictionary];
    NSString *randomWord = [wordsSource randomKey];
    while ([randomWord isEqualToString:_currentWord]) {
        randomWord = [wordsSource randomKey];
    }
    _currentWord = randomWord;
    _itemsPannel.lettersSource = [[randomWord wordToLetters] randomSorted];
    NSString *valueOfWord = [[JRDictionaryManager shareManager] searchWordsSourceWithWord:_currentWord];
    [self showChineseMessageInPannel:valueOfWord];
}
@end
