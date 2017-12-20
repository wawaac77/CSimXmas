//
//  CSFinalCompleteViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 20/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSFinalCompleteViewController.h"

@interface CSFinalCompleteViewController ()

@end

@implementation CSFinalCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = ScreenBounds;
    
    [self setUpInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpInit
{
    UILabel *bigLabel = [[UILabel alloc] init];
    [self.view addSubview:bigLabel];
    bigLabel.text = @"Complete!";
    
    self.completeText = @"Always be connected #UnleashTheMagicOfClubSIM Enjoy hassle-free data roaming service at over 175 destinations world wide!";
    UILabel *detailLabel = [[UILabel alloc] init];
    [self.view addSubview:detailLabel];
    detailLabel.text = self.completeText;
    detailLabel.font = [UIFont systemFontOfSize:15];
    //[detailLabel setFont:[UIFont systemFontOfSize:15]];
    detailLabel.numberOfLines = 0;
    
    CGFloat textMaxW = ScreenW - CSMargin * 2;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    CGSize textSize = [self.completeText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(CSMargin);
        make.right.equalTo(self.view).with.offset(-CSMargin);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(textSize.height);
    }];
    
}

@end
