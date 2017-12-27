//
//  CSNotificationTableViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 19/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSNotificationTableViewController.h"

#import "CSNotificationCell.h"

@interface CSNotificationTableViewController ()

@end

static NSString *const CSNotificationCellID = @"CSNotificationCellID";

@implementation CSNotificationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CSNotificationCell class]) bundle:nil] forCellReuseIdentifier:CSNotificationCellID];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cusCell = [UITableViewCell new];
    
    CSNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:CSNotificationCellID forIndexPath:indexPath];
    cusCell = cell;
   
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}

@end
