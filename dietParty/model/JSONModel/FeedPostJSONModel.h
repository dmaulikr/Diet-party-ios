//
//  FeedPostJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/8/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class FeedJSONModel;
@class CommentJSONModel;
@class CountJSONModel;
@class FeedUserJSONModel;
@class CheerupJSONModel;
@protocol FriendJSONModel;
@protocol ShareJSONModel;
@protocol CommentJSONModel;


@interface FeedPostJSONModel : JSONModel
@property (strong, nonatomic) FeedJSONModel *post;
@property (strong, nonatomic) NSArray <FriendJSONModel, Ignore>*friends;
@property (strong, nonatomic) NSArray <ShareJSONModel, Ignore>*share;
@property (strong, nonatomic) CommentJSONModel <Optional>*comment;
@property (strong, nonatomic) CountJSONModel *count;
@property (strong, nonatomic) FeedUserJSONModel *user;
@property (strong, nonatomic) id <Ignore> location;
//cheerup
@property (strong, nonatomic) CheerupJSONModel *cheerup;
//count

/*
 "post_id": "14",
 "content": "Ong ate a test",
 "hashtag": "#food ",
 "post_type": "2",
 "image_path": "https://s3-ap-southeast-1.amazonaws.com/dietparty/staging/5/post_1452181433.png",
 "location_name": null,
 "lat": null,
 "lng": null,
 "created_at": "2016-01-07 22:43:53",
 "updated_at": "2016-01-07 22:43:53",
 "friends": [],
 "share": [],
 "cheerup_count": "0",
 "comment_count": "0",
 "share_count": "0",
 "comment": null
 */

/*
 {
 cheerup =     {
 status = 0;
 };
 comment = "<null>";
 count =     {
 cheerup = 0;
 comment = 0;
 share = 0;
 };
 friends =     (
 {
 "first_name" = "Yung Ying";
 "last_name" = yyy;
 "user_friend_id" = 3;
 }
 );
 location =     {
 lat = "100.0100";
 lng = "13.0100";
 "location_name" = ATM;
 };
 post =     {
 content = "Gritsakorn has completed 60 mins exercise Bicycling";
 "created_at" = "2015-12-20 03:57:55";
 description = "";
 hashtag = "#Bike";
 "image_path" = "<null>";
 "post_id" = 3;
 "post_type" = 3;
 "updated_at" = "2015-12-20 03:57:55";
 };
 share =     {
 friends =         (
 {
 "first_name" = "Yung Ying";
 "last_name" = yyy;
 "user_friend_id" = 3;
 }
 );
 location =         {
 lat = "100.0100";
 lng = "13.0100";
 "location_name" = ATM;
 };
 post =         {
 content = "Gritsakorn has completed 60 mins exercise Bicycling";
 "created_at" = "2015-12-20 03:58:52";
 description = "";
 hashtag = "#Bike";
 id = 4;
 "image_path" = "https://s3-ap-southeast-1.amazonaws.com/dietparty/staging/1/post_1450558731.png";
 "updated_at" = "2015-12-20 03:58:52";
 };
 user =         {
 "first_name" = Gritsakorn;
 id = 1;
 "last_name" = Vulliyamatee;
 "profile_image_path" = "<null>";
 };
 };
 user =     {
 "first_name" = Gritsakorn;
 id = 1;
 "last_name" = Vulliyamatee;
 "profile_image_path" = "<null>";
 };
 }
 */
@end
