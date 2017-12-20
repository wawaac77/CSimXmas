//
//  CSGiftSelectViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 19/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSGiftSelectViewController.h"

#import "CSGiftHoldViewController.h"
//Models
#import "CSGiftModel.h"

/* cell */
#import "CSGiftCollectionViewCell.h"


@interface CSGiftSelectViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong, nonatomic) UICollectionView *collectionView;

@end

/* cell */
static NSString *const CSGiftCellID = @"CSGiftCellID";

@implementation CSGiftSelectViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(ScreenW / 2, ScreenW / 2);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - CSBottomTabH - CSTopNavH) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - CSBottomTabH - CSTopNavH);
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"CSGiftCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CSGiftCellID];
        
        [self.view addSubview:_collectionView];
    }
    
    return _collectionView;
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = self.view.backgroundColor;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    CSGiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSGiftCellID forIndexPath:indexPath];
    gridcell = cell;
    
    return gridcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CSGiftHoldViewController *giftHoldVC = [[CSGiftHoldViewController alloc] initWithNibName:@"CSGiftHoldViewController" bundle:nil];
    [self.navigationController pushViewController:giftHoldVC animated:YES];
}

/*
#pragma mark - item size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
        return CGSizeMake(ScreenW / 5, ScreenW / 5);
                          
}
 */

@end
