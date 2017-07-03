//
//  ActivitieJSONModel.m
//  dietParty
//
//  Created by Komsit choosangthong on 3/17/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "ActivitieJSONModel.h"

@implementation ActivitieJSONModel
+ (JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"identity"
                                                       }];
}
@end
