//
//  CSCardSelectTableViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 20/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSCardSelectTableViewController.h"
#import "CSCardCheckOutTableViewController.h"

#import "CSCardSelectContactCell.h"
#import "CSProgressBar.h"

#import "CSContactModel.h"

#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface CSCardSelectTableViewController () <iCarouselDelegate, iCarouselDataSource, CNContactPickerDelegate>

@property (nonatomic, strong) iCarousel *carouselView;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *cardImages;
@property (nonatomic, strong) NSMutableArray<CSContactModel *> *contactList;
@property (nonatomic, strong) NSNumber *currentCard;
@property (nonatomic, assign) BOOL wrap;

@end

static NSString *const CSCardContactCellID = @"CSCardContactCellID";
static CGFloat const buttonH = 50.0f;

@implementation CSCardSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    [self setUpCarouselView];
    [self setUpFooterView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpBase
{
    self.contactList = [[NSMutableArray alloc] init];
    self.currentCard = [[NSNumber alloc] init];
    self.currentCard = @0;
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CSCardSelectContactCell class]) bundle:nil] forCellReuseIdentifier:CSCardContactCellID];
}

- (void)setUpFooterView
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, CSMargin*4 + buttonH * 3)];
    
    UIButton *addRecipientButton = [[UIButton alloc] initWithFrame:CGRectMake(CSMargin, CSMargin, ScreenW - 2 * CSMargin, buttonH)];
    [footer addSubview:addRecipientButton];
    [addRecipientButton setBackgroundColor:XMasRedColor];
    [addRecipientButton setTitle:@"Add Recipient" forState:UIControlStateNormal];
    addRecipientButton.layer.cornerRadius = 4.0f;
    addRecipientButton.clipsToBounds = YES;
    [addRecipientButton addTarget:self action:@selector(addRecipientButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *continueButton = [[UIButton alloc] initWithFrame:CGRectMake(CSMargin, CSMargin*2 + buttonH, ScreenW - 2 * CSMargin, buttonH)];
    [footer addSubview:continueButton];
    [continueButton setBackgroundColor:XMasRedColor];
    [continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    continueButton.layer.cornerRadius = 4.0f;
    continueButton.clipsToBounds = YES;
    [continueButton addTarget:self action:@selector(continueButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    CSProgressBar *progressBar = [[CSProgressBar alloc] initWithFrame:CGRectMake(CSMargin, CSMargin*3 + buttonH * 2, ScreenW - 2 * CSMargin, buttonH)];
    [footer addSubview:progressBar];
    progressBar.step = @"1";
    
    self.tableView.tableFooterView = footer;
    
    
}

#pragma mark - Carousel
- (void)setUpCarouselView
{
    self.carouselView = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 300)];
    self.wrap = YES;
    self.cards = [NSMutableArray array];
    self.cardImages = [[NSMutableArray alloc] initWithObjects:@"1_en.png",@"2_en.png",@"3_en.png",@"4_en.png",@"5_en.png",@"8_en.png",@"10_en.png", @"11_en.png",@"13_en.png", @"14_en.png",@"15_en.png", nil];
    for (int i = 0; i < _cardImages.count; i++)
    {
        [self.cards addObject:@(i)];
    
    }
    NSLog(@"self.cardImages.count %ld", self.cardImages.count);
    NSLog(@"self.cards.count %ld", self.cards.count);
    
    self.carouselView.type = iCarouselTypeCoverFlow;
    self.carouselView.delegate = self;
    self.carouselView.dataSource = self;
    
    self.tableView.tableHeaderView = self.carouselView;
    self.tableView.sectionHeaderHeight = 300 + CSMargin * 2;
}

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    
    return _cardImages.count;
    //return (NSInteger)[self.cardImages count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, CSMargin, 200.0, 200.0)];
        ((UIImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _cardImages[index]]];
        NSLog(@"index in viewForItemAtIndex %ld", index);
        view.clipsToBounds = YES;
        view.contentMode = UIViewContentModeScaleAspectFit;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    
    ((UIImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", _cardImages[index]]];
    //label.text = [self.cards[(NSUInteger)index] stringValue];
    
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"cs_logo.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    NSLog(@"indxe placeholderViewAtIndex %ld", index);
    
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0.0, 1.0, 0.0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carouselView.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carouselView.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.cards)[(NSUInteger)index];
    NSLog(@"Tapped view number: %@", item);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carouselView.currentItemIndex));
}

#pragma mark - Table view
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contactList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cusCell = [UITableViewCell new];
    
    CSCardSelectContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCardContactCellID forIndexPath:indexPath];
    cusCell = cell;
    
    CGFloat delteButtonW = 30.0f;
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenW - CSMargin - delteButtonW, (44 - delteButtonW) / 2, delteButtonW, delteButtonW)];
    [cell addSubview:deleteButton];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"deleteButton.png"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    cell.thisContact = [_contactList objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - contactPicker
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    
    NSLog(@"%@",contactProperty);
    CNContact *contact = contactProperty.contact;
    NSLog(@"givenName: %@, familyName: %@", contact.givenName, contact.familyName);
    //self.nameLabel.text = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
    if (![contactProperty.value isKindOfClass:[CNPhoneNumber class]]) {
        //        [[HNPublicTool shareInstance] showHudErrorMessage:@"请选择11位手机号"];
        return;
    }
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString * Str = phoneNumber.stringValue;
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789"]invertedSet];
    NSString *phoneStr = [[Str componentsSeparatedByCharactersInSet:setToRemove]componentsJoinedByString:@""];
    if (phoneStr.length != 11) {
        //        [[HNPublicTool shareInstance] showHudErrorMessage:@"请选择11位手机号"];
    }
    NSLog(@"-=-=%@",phoneStr);
    
    CSContactModel *newContact = [[CSContactModel alloc] init];
    newContact.contactNum = phoneStr;
    newContact.contactName = [NSString stringWithFormat:@"%@ %@",contact.familyName,contact.givenName];
    [_contactList addObject:newContact];
    [self.tableView reloadData];
    
    //self.telNumber.text = phoneStr;
}

#pragma mark - Button Clicked
- (void)addRecipientButtonClicked {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) {
                NSLog(@"unauthorized");
            } else  {
                NSLog(@"sucess");//user gave the authority
                CNContactPickerViewController *picker = [CNContactPickerViewController new];
                picker.delegate = self;
                picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];//only show phone num
                [self presentViewController: picker  animated:YES completion:nil];
            }
        }];
    } if (status == CNAuthorizationStatusAuthorized) {//有权限时
        CNContactPickerViewController * picker = [CNContactPickerViewController new];
        picker.delegate = self;
        picker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController: picker  animated:YES completion:nil];
        
    } else {
        NSLog(@"您未开启通讯录权限,请前往设置中心开启");
    }
}

- (void)continueButtonClicked {
    CSCardCheckOutTableViewController *checkoutVC = [[CSCardCheckOutTableViewController alloc] init];
    checkoutVC.contactList = _contactList;
    checkoutVC.cardImage = [_cardImages objectAtIndex: self.carouselView.currentItemIndex];
    NSLog(@"continueButton self.carouselView.currentItemIndex %ld", self.carouselView.currentItemIndex);
    [self.navigationController pushViewController:checkoutVC animated:YES];
}

- (void)deleteButtonClicked {
    [_contactList removeObjectAtIndex:(NSUInteger)[self.tableView indexPathForSelectedRow]];
    [self.tableView reloadData];
}


@end
