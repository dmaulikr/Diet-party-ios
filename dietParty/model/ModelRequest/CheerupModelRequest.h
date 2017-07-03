//
//  CheerupModelRequest.h
//  dietParty
//
//  Created by Komsit choosangthong on 2/18/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface CheerupModelRequest : BaseModelRequest
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSNumber *post_id;
@end
