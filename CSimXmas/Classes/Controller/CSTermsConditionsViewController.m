//
//  CSTermsConditionsViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 19/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSTermsConditionsViewController.h"

@interface CSTermsConditionsViewController ()

@end

@implementation CSTermsConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpNav
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"pexels-photo-370799.jpeg"] forBarMetrics:UIBarMetricsDefault];
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
