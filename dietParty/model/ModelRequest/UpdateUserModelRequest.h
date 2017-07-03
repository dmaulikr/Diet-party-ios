//
//  UpdateUserModelRequest.h
//  dietParty
//
//  Created by Komsit choosangthong on 12/26/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "GetuserModelRequest.h"

@interface UpdateUserModelRequest : GetuserModelRequest
@property (strong, nonatomic) NSString <Optional>*first_name;
@property (strong, nonatomic) NSString <Optional>*last_name;
@property (strong, nonatomic) NSString <Optional>*email;
@property (strong, nonatomic) NSString <Optional>*password;
@property (strong, nonatomic) NSString <Optional>*facebook_id;
@property (strong, nonatomic) NSString <Optional>*profile_image_path;
@property (strong, nonatomic) NSString <Optional>*cover_image_path;
@property (strong, nonatomic) NSNumber <Optional>*weight_target;
@property (assign, nonatomic) NSNumber <Optional>*weight;
@property (assign, nonatomic) NSNumber <Optional>*height;
@property (strong, nonatomic) NSString <Optional>*gender;
@property (strong, nonatomic) NSString <Optional>*birthday;
@property (assign, nonatomic) NSNumber <Optional>*activity;
@property (strong, nonatomic) NSNumber <Optional>*body_fat;



@end
