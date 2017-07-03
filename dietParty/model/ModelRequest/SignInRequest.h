//
//  SignInRequest.h
//  dietParty
//
//  Created by Komsit choosangthong on 11/26/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface SignInRequest : BaseModelRequest
@property (strong, nonatomic) NSString *grant_type;
@property (strong, nonatomic) NSString *client_id;
@property (strong, nonatomic) NSString *client_secret;
@property (strong, nonatomic) NSString *type_login;

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@end
