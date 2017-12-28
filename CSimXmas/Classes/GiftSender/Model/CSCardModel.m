//
//  CSCardModel.m
//  CSimXmas
//
//  Created by Alice Jin on 28/12/2017.
//  Copyright © 2017 Alice Jin. All rights reserved.
//

#import "CSCardModel.h"

@implementation CSCardModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"cardId" : @"id",
             @"cardDescription" : @"description",
             };
}

@end
