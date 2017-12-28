//
//  CSProgressBar.m
//  CSimXmas
//
//  Created by Alice Jin on 18/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSProgressBar.h"

@interface CSProgressBar ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button_one;
@property (weak, nonatomic) IBOutlet UIButton *button_two;
@property (weak, nonatomic) IBOutlet UIButton *button_three;

@end

#define buttonW 20.0f;

@implementation CSProgressBar

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self customInit];
    }
    
    return self;
}

- (void)customInit {
    [[NSBundle mainBundle] loadNibNamed:@"CSProgressBar" owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    
}

- (void)setStep:(NSString *)step
{
    _step = step;
    
    if ([_step isEqualToString:@"1"]) {
        [_button_one setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Yellow-icon.png"] forState:UIControlStateNormal];
        [_button_two setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Gray-icon.png"] forState:UIControlStateNormal];
        [_button_three setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Gray-icon.png"] forState:UIControlStateNormal];
    } else if ([_step isEqualToString:@"2"]) {
        [_button_one setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Gray-icon.png"] forState:UIControlStateNormal];
        [_button_two setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Yellow-icon.png"] forState:UIControlStateNormal];
        [_button_three setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Gray-icon.png"] forState:UIControlStateNormal];
    } else if ([_step isEqualToString:@"3"]) {
        [_button_one setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Gray-icon.png"] forState:UIControlStateNormal];
        [_button_two setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Gray-icon.png"] forState:UIControlStateNormal];
        [_button_three setBackgroundImage:[UIImage imageNamed:@"Button-Blank-Yellow-icon.png"] forState:UIControlStateNormal];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(ScreenW - 2 * CSMargin, 5));
    }];
    
    [_button_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_left);
        make.centerY.equalTo(_imageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_button_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_imageView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_button_three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imageView.mas_right);
        make.centerY.equalTo(_imageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
