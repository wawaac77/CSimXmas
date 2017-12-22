//
//  CSGiftHomeViewController.h
//  CSimXmas
//
//  Created by Alice Jin on 18/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSGiftHomeViewController.h"
#import "CSGiftSelectViewController.h"
#import "CSGiftHoldViewController.h"
#import "CSNotificationTableViewController.h"
#import "CSTermsConditionsViewController.h"
#import "CSCardSelectTableViewController.h"

#import <Masonry.h>

@interface CSGiftHomeViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *bigTitleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UIButton *continueButton;

@end

@implementation CSGiftHomeViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.scrollEnabled = YES;
        _scrollerView.bounces = NO;
        _scrollerView.delegate = self;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Club SIM";
    [self setUpInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)setUpInit {
    self.view.frame = ScreenBounds;
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(ScreenW, 0);
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CSMargin, CSMargin, ScreenW - CSMargin * 2, (ScreenW - CSMargin * 2) * 0.8)];
    [self.scrollerView addSubview:_imageView];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.image = [UIImage imageNamed:@"Limited-christmas.png"];
    
    self.bigTitleLabel = [[UILabel alloc] init];
    [self.scrollerView addSubview:self.bigTitleLabel];
    [_bigTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 
        make.top.equalTo(_imageView.mas_bottom).with.offset(CSMargin);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(_imageView.mas_width);
        make.centerX.mas_equalTo(_imageView.mas_centerX);
        
    }];
    self.bigTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.bigTitleLabel.backgroundColor = [UIColor yellowColor];
    self.bigTitleLabel.text = @"Xmas card";
    
    self.detailLabel = [[UILabel alloc] init];
    [self.scrollerView addSubview:self.detailLabel];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.text = @"iCremeria is a special gift iCremeria is a special giftiCremeria is a special giftiCremeria is a special gift";
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).with.offset(CSMargin);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(_imageView.mas_width);
        make.centerX.mas_equalTo(_imageView.mas_centerX);
    }];
    
    self.continueButton = [[UIButton alloc] init];
    [self.scrollerView addSubview:_continueButton];
    [_continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailLabel.mas_bottom).with.offset(CSMargin);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(_imageView.mas_width);
        make.centerX.mas_equalTo(_imageView.mas_centerX);
    }];
    _continueButton.backgroundColor = [UIColor lightGrayColor];
    [_continueButton setTitle:@"Continue" forState:UIControlStateNormal];
    [_continueButton addTarget:self action:@selector(continueButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(CSMargin, CSMargin, ScreenW - CSMargin * 2, (ScreenW - CSMargin * 2) * 0.8)];
    [self.scrollerView addSubview:imageButton];
    [imageButton addTarget:self action:@selector(imageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)continueButtonClicked {
    CSGiftHoldViewController *giftHoldVC = [[CSGiftHoldViewController alloc] initWithNibName:@"CSGiftHoldViewController" bundle:nil];
    [self.navigationController pushViewController:giftHoldVC animated:YES];
    
}

- (void)imageButtonClicked {
    CSCardSelectTableViewController *cardVC = [[CSCardSelectTableViewController alloc] initWithNibName:@"CSCardSelectTableViewController" bundle:nil];
    [self.navigationController pushViewController:cardVC animated:YES];
    
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
