//
//  FeedUserJSONModel.m
//  dietParty
//
//  Created by Komsit choosangthong on 1/26/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "FeedUserJSONModel.h"

@implementation FeedUserJSONModel
+ (JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"identity"
                                                       }];
}
@end
