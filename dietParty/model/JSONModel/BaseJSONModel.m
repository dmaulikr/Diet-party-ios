//
//  BaseJSONModel.m
//  dietParty
//
//  Created by Komsit choosangthong on 11/25/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "BaseJSONModel.h"

@implementation BaseJSONModel
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"status": @"status"
                                                       }];
}
@end
