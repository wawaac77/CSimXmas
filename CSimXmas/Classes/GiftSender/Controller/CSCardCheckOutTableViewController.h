//
//  CSCardCheckOutTableViewController.h
//  CSimXmas
//
//  Created by Alice Jin on 27/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSContactModel;

@interface CSCardCheckOutTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<CSContactModel *> *contactList;
@property (nonatomic, strong) NSString *cardImage;

@end
