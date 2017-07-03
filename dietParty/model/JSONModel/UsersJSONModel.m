//
//  UsersJSONModel.m
//  dietParty
//
//  Created by Komsit choosangthong on 11/25/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "UsersJSONModel.h"

@implementation UsersJSONModel
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"identity"
                                                       }];
}
@end
