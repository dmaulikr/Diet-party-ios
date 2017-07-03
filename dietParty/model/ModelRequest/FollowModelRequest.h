//
//  FollowModelRequest.h
//  dietParty
//
//  Created by Komsit choosangthong on 4/3/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface FollowModelRequest : BaseModelRequest
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *user_follow_id;
@end
