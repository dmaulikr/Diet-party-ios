//
//  Getuser.h
//  dietParty
//
//  Created by Komsit choosangthong on 11/26/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface GetuserModelRequest : BaseModelRequest
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSNumber <Optional>*limit;
@property (strong, nonatomic) NSNumber <Optional>*offset;
@end
