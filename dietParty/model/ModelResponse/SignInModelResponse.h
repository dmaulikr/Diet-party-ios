//
//  SignInModelResponse.h
//  dietParty
//
//  Created by Komsit choosangthong on 11/26/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "BaseModelResponse.h"

@interface SignInModelResponse : BaseModelResponse
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *token_type;
@property (strong, nonatomic) NSString *expires_in;
@end
