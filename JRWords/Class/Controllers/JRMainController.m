//
//  JRMainController.m
//  JRWords
//
//  Created by Jaben on 14-10-18.
//  Copyright (c) 2014年 Jaben. All rights reserved.
//

#import "JRMainController.h"
#import "JRItemsPannel.h"

@interface JRMainController ()
@property (nonatomic, strong) JRItemsPannel *itemsPannel;
@end

@implementation JRMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _itemsPannel =  [[JRItemsPannel alloc] initWithFrame:CGRectMake(0, 50, self.view.width, 300)];
    _itemsPannel.lettersSource = @[@"c",@"a",@"t",@"e"];
    [self.view addSubview:_itemsPannel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
