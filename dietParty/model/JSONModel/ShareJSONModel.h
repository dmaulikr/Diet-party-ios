//
//  ShareJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/8/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ShareJSONModel : JSONModel
@property (strong, nonatomic) NSString *share_post_id;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString <Optional>*profile_image_path;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString <Optional>*hashtag;
@property (strong, nonatomic) NSString <Optional>*image_path;
@property (strong, nonatomic) NSString <Optional>*location_name;
@property (strong, nonatomic) NSString <Optional>*lat;
@property (strong, nonatomic) NSString <Optional>*lng;
@property (strong, nonatomic) NSString *created_at;
@property (strong, nonatomic) NSString *updated_at;
/*
 "share": [
 {
 "share_post_id": "4",
 "user_id": "1",
 "first_name": "Gritsakorn",
 "last_name": "Vulliyamatee",
 "profile_image_path": null,
 "content": "Gritsakorn has completed 60 mins exercise Bicycling",
 "hashtag": "#Bike",
 "image_path": "https://s3-ap-southeast-1.amazonaws.com/dietparty/staging/1/post_1450558731.png",
 "location_name": "ATM",
 "lat": "100.0100",
 "lng": "13.0100",
 "created_at": "2015-12-20 03:58:52",
 "updated_at": "2015-12-20 03:58:52",
 "friends": [
 {
 "user_friend_id": "2",
 "first_name": "ongyoo",
 "last_name": "ongyoo"
 },
 {
 "user_friend_id": "3",
 "first_name": "Yung Ying",
 "last_name": "yyy"
 },
 {
 "user_friend_id": "4",
 "first_name": "ongyoo",
 "last_name": "ongyoo"
 }
 ]
 }
 ]
 */
@end
