//
//  CSCompleteViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 18/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSCompleteViewController.h"
#import "CSGiftSelectViewController.h"
#import "CSFinalCompleteViewController.h"
#import "CSNotificationTableViewController.h"
#import "CSTermsConditionsViewController.h"

#import "CSProgressBar.h"

@interface CSCompleteViewController ()

@end

@implementation CSCompleteViewController



#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = ScreenBounds;
    self.navigationItem.title = @"Club SIM";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)setUpBase {
    CSProgressBar *prgressBar = [[CSProgressBar alloc] init];
    [self.view addSubview:prgressBar];
    prgressBar.step = @"2";
    [prgressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(ScreenW - CSMargin * 2);
        make.height.mas_equalTo(50);
    }];
}

- (IBAction)RedeemButtonClicked:(id)sender
{
    CSFinalCompleteViewController *completeVC = [[CSFinalCompleteViewController alloc] initWithNibName:@"CSFinalCompleteViewController" bundle:nil];
    [self.navigationController pushViewController:completeVC animated:YES];
}

- (IBAction)FAQButtonClicked:(id)sender
{
    CSTermsConditionsViewController *termsVC = [[CSTermsConditionsViewController alloc] initWithNibName:@"CSTermsConditionsViewController" bundle:nil];
    [self.navigationController pushViewController:termsVC animated:YES];
}

- (IBAction)notificationButtonClicked:(id)sender
{
    CSNotificationTableViewController *notificationVC = [[CSNotificationTableViewController alloc] init];
    [self.navigationController pushViewController:notificationVC animated:YES];
}


@end
