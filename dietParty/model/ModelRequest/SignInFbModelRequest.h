//
//  SignInFbModelRequest.h
//  dietParty
//
//  Created by Komsit choosangthong on 12/3/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "BaseModelRequest.h"

@interface SignInFbModelRequest : BaseModelRequest
@property (strong, nonatomic) NSString *grant_type;
@property (strong, nonatomic) NSString *client_id;
@property (strong, nonatomic) NSString *client_secret;
@property (strong, nonatomic) NSString *type_login;

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *profile_image_path;

@end
