//
//  CSGiftHoldViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 19/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSGiftHoldViewController.h"
#import "CSCompleteViewController.h"

#import "CSProgressBar.h"

@interface CSGiftHoldViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *bigTitleLabel;
@property (strong, nonatomic) UILabel *detailLabel;
@property (strong, nonatomic) UIButton *holdGiftButton;

@end

@implementation CSGiftHoldViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.scrollEnabled = YES;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.bounces = NO;
        _scrollerView.delegate = self;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = ScreenBounds;
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(ScreenW, ScreenH + 100);
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CSMargin, CSNavH + CSMargin, ScreenW - CSMargin * 2, (ScreenW - CSMargin * 2) * 0.8)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"iCremeria.png"];
    [self.scrollerView addSubview:_imageView];
    
    self.bigTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CSMargin, (ScreenW - CSMargin * 2) * 0.8 + CSMargin + CSNavH + CSMargin, ScreenW - CSMargin * 2, 50)];
    self.bigTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.bigTitleLabel.text = @"iCremeria";
    [self.scrollerView addSubview:self.bigTitleLabel];
    
    self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CSMargin, (ScreenW - CSMargin * 2) * 0.8 + CSMargin + CSNavH + CSMargin + 50 + CSMargin, ScreenW - CSMargin * 2, 150)];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.text = @"iCremeria is a special gift iCremeria is a special giftiCremeria is a special giftiCremeria is a special gift";
    [self.scrollerView addSubview:self.detailLabel];
    
    self.holdGiftButton = [[UIButton alloc] initWithFrame:CGRectMake(CSMargin, (ScreenW - CSMargin * 2) * 0.8 + CSMargin + CSNavH + CSMargin + 50 + CSMargin  + 150 , ScreenW - CSMargin * 2, 100)];
    _holdGiftButton.backgroundColor = [UIColor lightGrayColor];
    [_holdGiftButton setTitle:@"Hold Gift" forState:UIControlStateNormal];
    [_holdGiftButton addTarget:self action:@selector(holdGiftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollerView addSubview:_holdGiftButton];
    
    CSProgressBar *prgressBar = [[CSProgressBar alloc] init];
    [self.view addSubview:prgressBar];
    prgressBar.backgroundColor = [UIColor redColor];
    prgressBar.step = @"1";
    
    [prgressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(ScreenW - CSMargin * 2);
        make.height.mas_equalTo(50);
    }];
    
    
}

#pragma mark - button clicked
- (void)holdGiftButtonClicked
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Are you sure?"
                                                                             message:@"By Clicking 'yes', you will agree to the terms and conditions and will hold your stock of this gift. You will not be able to switch gifts."

                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"No"
                                                       style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         NSLog(@"actionNo");
                                                     }];
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"Yes"
                                                       style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          NSLog(@"actionYes");
                                                          CSCompleteViewController *completeVC = [[CSCompleteViewController alloc] initWithNibName:@"CSCompleteViewController" bundle:nil];
                                                          [self.navigationController pushViewController:completeVC animated:YES];
                                                      }];
    [alertController addAction:actionNo];
    [alertController addAction:actionYes];
    [self presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
