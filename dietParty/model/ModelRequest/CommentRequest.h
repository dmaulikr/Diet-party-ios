//
//  CommentRequest.h
//  dietParty
//
//  Created by Komsit choosangthong on 2/27/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface CommentRequest : BaseModelRequest
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSNumber *limit;
@property (strong, nonatomic) NSNumber *offset;
@end
