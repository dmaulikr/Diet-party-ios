//
//  UserModelResponse.h
//  dietParty
//
//  Created by Komsit choosangthong on 11/26/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "BaseModelResponse.h"

@interface UserModelResponse : JSONModel

@property (assign, nonatomic) NSNumber *identity;
@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString <Optional>*user_id;
@property (strong, nonatomic) NSString <Optional>*energy;
@property (strong, nonatomic) NSString <Optional>*email;
@property (strong, nonatomic) NSString <Optional>*facebook_id;
@property (strong, nonatomic) NSString <Optional>*profile_image_path;
@property (strong, nonatomic) NSString <Optional>*cover_image_path;
@property (assign, nonatomic) NSString <Optional>*weight_target;
@property (assign, nonatomic) NSString *height;
@property (assign, nonatomic) NSString <Optional>*weight_current;
@property (assign, nonatomic) NSString <Optional>*weight_result;
@property (strong, nonatomic) NSString <Optional>*gender;
@property (strong, nonatomic) NSString <Optional>*birthday;
@property (assign, nonatomic) NSNumber <Optional>*activity;
@property (assign, nonatomic) NSString <Optional>*friend_count;
@property (strong, nonatomic) NSString <Optional>*body_fat;

/*
 {
 activity = 0;
 birthday = "1992-05-22";
 "body_fat" = "25.0";
 "cover_image_path" = "https://s3-ap-southeast-1.amazonaws.com/dietparty/staging/5/cover_1450590958.jpg";
 email = "<null>";
 energy = "<null>";
 "facebook_id" = 1087098871340292;
 "first_name" = Ong;
 "friend_count" = 1;
 gender = m;
 height = "170.0";
 id = 5;
 "last_name" = Chusangthong;
 "profile_image_path" = "https://graph.facebook.com/1087098871340292/picture?type=large";
 "user_id" = "<null>";
 "weight_current" = "45.0";
 "weight_result" = "21.0";
 "weight_target" = "42.0";
 }
 */

/*
 "id": "5",
 "first_name": "Ong",
 "last_name": "Chusangthong",
 "email": null,
 "facebook_id": "1087098871340292",
 "profile_image_path": "https://graph.facebook.com/1087098871340292/picture?type=large",
 "cover_image_path": "https://s3-ap-southeast-1.amazonaws.com/dietparty/staging/5/cover_1450590958.jpg",
 "weight_target": "42.0",
 "weight_current": "45.0",
 "height": "170.0",
 "gender": "m",
 "birthday": "1992-05-22",
 "activity": "0",
 "body_fat": "25.0",
 "user_id": null,
 "energy": null,
 "friend_count": "1",
 "weight_result": "21.0"
 */

@end
