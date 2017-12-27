//
//  CSCardSelectContactCell.h
//  CSimXmas
//
//  Created by Alice Jin on 20/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSContactModel.h"

@interface CSCardSelectContactCell : UITableViewCell

@property (strong, nonatomic) CSContactModel *thisContact;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
