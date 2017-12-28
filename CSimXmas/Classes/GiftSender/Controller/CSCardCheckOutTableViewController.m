//
//  CSCardCheckOutTableViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 27/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSCardCheckOutTableViewController.h"

#import "CSCardSelectContactCell.h"
#import "CSProgressBar.h"

#import "CSContactModel.h"

@interface CSCardCheckOutTableViewController ()

@property (strong, nonatomic) NSNumber *freeQuota;
@property (strong, nonatomic) NSNumber *totalPrice;

@end

static NSString *const CSCardContactCellID = @"CSCardContactCellID";
static CGFloat const buttonH = 50.0f;

@implementation CSCardCheckOutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    [self setUpHeaderView];
    [self setUpFooterView];
    
    [self getFreeCardQuota];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpBase
{
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CSCardSelectContactCell class]) bundle:nil] forCellReuseIdentifier:CSCardContactCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID"];
}

- (void)setUpHeaderView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 300)];
    self.tableView.tableHeaderView = header;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CSMargin, CSMargin, ScreenW - 2*CSMargin, 300 - 2*CSMargin)];
    [header addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:_cardImage];
}

- (void)setUpFooterView
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, CSMargin * 4 + buttonH * 3)];
    
    UIButton *addRecipientButton = [[UIButton alloc] initWithFrame:CGRectMake(CSMargin, CSMargin, ScreenW - 2 * CSMargin, buttonH)];
    [footer addSubview:addRecipientButton];
    [addRecipientButton setBackgroundColor:XMasRedColor];
    [addRecipientButton setTitle:@"Checkout" forState:UIControlStateNormal];
    addRecipientButton.layer.cornerRadius = 4.0f;
    addRecipientButton.clipsToBounds = YES;
    [addRecipientButton addTarget:self action:@selector(checkoutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    CSProgressBar *progressBar = [[CSProgressBar alloc] initWithFrame:CGRectMake(CSMargin, CSMargin * 2 + buttonH, ScreenW - 2 * CSMargin, buttonH)];
    [footer addSubview:progressBar];
    progressBar.step = @"2";
    
    self.tableView.tableFooterView = footer;
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _contactList.count;
    } else {
        return 2;
    }
    
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cusCell = [UITableViewCell new];
    
    if (indexPath.section == 0) {
        CSCardSelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCardContactCellID forIndexPath:indexPath];
        cusCell = cell;
        cell.thisContact = [_contactList objectAtIndex:indexPath.row];
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID" forIndexPath:indexPath];
        cusCell = cell;
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"Free Quota = %@", _freeQuota];
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"Total Price = %@", _totalPrice];
        }
    }
    
    return cusCell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - API
- (void)getFreeCardQuota {
    NSDictionary *dict = @{
                           @"sid" : @"eyJraWQiOiI4MDU4NDc4MDUxIiwidHlwIjoiSldUIiwiYWxnIjoiSFMyNTYifQ.eyJleHAiOjE1MjE2MjYyNTl9.XGykBaQdoZ_0QxB6c6K6qj5h0FX0-E0GTmn-J72_Y8Y",
                           };
    NSString *thisAPI = [NSString stringWithFormat:@"%@getFreeQuota", XMAS_API];

    [RequestTool requestWithType:GET URL:thisAPI parameter:dict successComplete:^(id responseObject) {
        NSLog(@"response status %@", [responseObject valueForKey:@"status"]);
        NSLog(@"response freeQuota %@", responseObject[@"freeQuota"]);
        self.freeQuota = responseObject[@"freeQuota"];
        //self.freeQuota = [NSNumber mj_objectWithKeyValues:responseObject[@"freeQuota"]];
        NSLog(@"_freeQuota %@", _freeQuota);
        [self calculateTotalPrice];
        
    } failureComplete:^(NSError *error) {
        NSLog(@"getFreeCardQuota failed");
    }];
}

- (void)calculateTotalPrice {
    NSInteger cardToPayNum = 0;
    if (_contactList.count > _freeQuota.integerValue) {
        cardToPayNum = _contactList.count - [_freeQuota integerValue];
    }
    
    //NSInteger cardToPayNum = _contactList.count < (NSInteger)_freeQuota ? 0 : _contactList.count - (NSInteger)_freeQuota.intValue;
    self.totalPrice = [NSNumber numberWithInteger:(cardToPayNum * 50)];
    
    [self.tableView reloadData];
}

#pragma mark - Button Clicked
- (void)checkoutButtonClicked {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Redirect to Tap and Go"
                                                                             message:@"By Clicking 'yes', you will agree to the terms and conditions and will be redirected to Tap and Go application to complete your payment."
                                          
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"No"
                                                       style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         NSLog(@"actionNo");
                                                     }];
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"Yes"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          NSLog(@"actionYes, to tap and go");
                                                          
                                                      }];
    [alertController addAction:actionNo];
    [alertController addAction:actionYes];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
