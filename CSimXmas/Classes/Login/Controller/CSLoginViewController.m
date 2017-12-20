//
//  CSLoginViewController.m
//  CSimXmas
//
//  Created by Alice Jin on 20/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSLoginViewController.h"

@interface CSLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButtonClicked:(id)sender;

@end

@implementation CSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES]; //navBar hide
    
    self.view.frame = ScreenBounds;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"christmas_background.jpg"]];
    
    [self setUpBase];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpBase {
    self.pwTextField.secureTextEntry = YES;
}

#pragma mark - button clicked
- (IBAction)loginButtonClicked:(id)sender {
    NSLog(@"login button clicked");
    [self getApiData];
}

- (void)getApiData {
    NSDictionary *dict = @{
                           @"action" : @"login",
                           @"platform" : @"ios",
                           @"lang" : @"en",
                           @"u" : self.nameTextField.text,
                           @"p" : self.pwTextField.text,
                           };
    
    [RequestTool requestWithType:POST URL:LAB_API parameter:dict successComplete:^(id responseObject) {
        NSLog(@"response %@", [responseObject valueForKey:@"description"]);
        if ([[responseObject valueForKey:@"code"] intValue] == 0) {
            NSLog(@"sid%@, mrtlist%@",[responseObject valueForKey:@"sid"],[[responseObject valueForKey:@"mrtlist"] valueForKey:@"status"]);
        }
        
    } failureComplete:^(NSError *error) {
        
        NSLog(@"Login fail");
        
    }];
    
}
@end
