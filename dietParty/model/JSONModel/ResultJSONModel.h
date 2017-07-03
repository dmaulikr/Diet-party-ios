//
//  ResultJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 11/25/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "BaseJSONModel.h"

@interface ResultJSONModel : BaseJSONModel

@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *token_type;
@property (strong, nonatomic) NSString *expires_in;
@end
