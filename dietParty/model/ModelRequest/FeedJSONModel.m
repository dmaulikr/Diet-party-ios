//
//  FeedJSONModel.m
//  dietParty
//
//  Created by Komsit choosangthong on 1/26/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "FeedJSONModel.h"

@implementation FeedJSONModel
+ (JSONKeyMapper*)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"post_id": @"identity",
                                                       @"description": @"desc"
                                                       }];
}
@end
