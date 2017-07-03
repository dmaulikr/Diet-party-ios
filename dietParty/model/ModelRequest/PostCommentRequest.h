//
//  PostCommentRequest.h
//  dietParty
//
//  Created by Komsit choosangthong on 3/5/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface PostCommentRequest : BaseModelRequest
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSNumber *post_id;
@property (strong, nonatomic) NSString *comment;
@end
