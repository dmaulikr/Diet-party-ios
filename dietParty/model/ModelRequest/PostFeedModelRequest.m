//
//  PostFeedModelRequest.m
//  dietParty
//
//  Created by Komsit on 1/10/2559 BE.
//  Copyright © 2559 Komsit. All rights reserved.
//

#import "PostFeedModelRequest.h"

@implementation PostFeedModelRequest
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"description": @"desc"
                                                       }];
}
@end
