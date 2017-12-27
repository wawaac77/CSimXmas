//
//  CSCardSelectContactCell.m
//  CSimXmas
//
//  Created by Alice Jin on 20/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSCardSelectContactCell.h"

@implementation CSCardSelectContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setThisContact:(CSContactModel *)thisContact {
    _thisContact = thisContact;
    _numLabel.text = thisContact.contactNum;
    _nameLabel.text = thisContact.contactName;
}

@end
