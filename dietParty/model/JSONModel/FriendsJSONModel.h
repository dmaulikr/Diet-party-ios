//
//  FriendsJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 4/24/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FriendsJSONModel : JSONModel
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString <Optional>*profile_image_path;
@property (strong, nonatomic) NSString *body_fat;
@property (strong, nonatomic) NSString *weight_loss;
@end
