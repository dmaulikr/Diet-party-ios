//
//  FriendJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/8/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FriendJSONModel : JSONModel
@property (strong, nonatomic) NSString *user_friend_id;
@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;

@end
