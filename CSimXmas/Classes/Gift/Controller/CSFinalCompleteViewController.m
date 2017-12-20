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
    self.completeText = @"Always be connected UnleashTheMagicOfClubSIM Enjoy hassle-free data roaming service at over 175 destinations world wide! Always be connected UnleashTheMagicOfClubSIM Enjoy hassle-free data roaming service at over 175 destinations world wide!Always be connected UnleashTheMagicOfClubSIM Enjoy hassle-free data roaming service at over 175 destinations world wide!";
    
    UILabel *bigLabel = [[UILabel alloc] init];
    [self.view addSubview:bigLabel];
    bigLabel.text = @"Complete!";
    bigLabel.textAlignment = NSTextAlignmentCenter;
    bigLabel.font = [UIFont boldSystemFontOfSize:21];
    [bigLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(ScreenW - 2 * CSMargin, 80));
    }];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    [self.view addSubview:detailLabel];
    detailLabel.text = self.completeText;
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.numberOfLines = 0;
    detailLabel.clipsToBounds = YES;
    //calculate textSize
    CGSize textMaxSize = CGSizeMake(ScreenW - CSMargin * 2, MAXFLOAT);
    CGSize textSize = [self.completeText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bigLabel.mas_bottom).with.offset(40);
        make.left.equalTo(self.view.mas_left).with.offset(CSMargin);
        make.right.equalTo(self.view.mas_right).with.offset(-CSMargin);
        //make.centerX.mas_equalTo(self.view.mas_centerX);
        //make.center.mas_equalTo(self.view);
        //make.size.mas_equalTo(textSize);
    }];
    
    UIButton *sendFriendButton = [[UIButton alloc] init];
    [self.view addSubview:sendFriendButton];
    [sendFriendButton setTitle:@"Send to a friend!" forState:UIControlStateNormal];
    [sendFriendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        n
    }];

}

@end
