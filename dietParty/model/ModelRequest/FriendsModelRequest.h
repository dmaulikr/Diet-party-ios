//
//  FriendsModelRequest.h
//  dietParty
//
//  Created by Komsit choosangthong on 4/24/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface FriendsModelRequest : BaseModelRequest
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *limit;
@property (strong, nonatomic) NSString *offset;
@end
