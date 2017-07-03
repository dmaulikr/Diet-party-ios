//
//  UpdateWeightModelRequest.h
//  dietParty
//
//  Created by Komsit on 12/3/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface UpdateWeightModelRequest : BaseModelRequest
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *weight;
@property (strong, nonatomic) NSString *body_fat;
@end
