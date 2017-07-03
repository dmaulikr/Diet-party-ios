//
//  PostJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/7/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PostJSONModel : JSONModel
@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString <Optional>*content; // post type = 1
@property (strong, nonatomic) NSNumber <Optional>*post_type; //1 = share,2 = food, 3 = excercise
@property (strong, nonatomic) NSData <Optional>*image;
@property (strong, nonatomic) NSString <Optional>*hashtag; //#food #calories
@property (strong, nonatomic) NSString <Optional>*location_name;
@property (strong, nonatomic) NSString <Optional>*lat;
@property (strong, nonatomic) NSString <Optional>*lng;
@property (strong, nonatomic) NSNumber <Optional>*share_post_id; //post type = 1
@property (strong, nonatomic) NSNumber <Optional>*share_user_id; //post type = 1
@property (strong, nonatomic) NSString <Optional>*user_friend_id; //2,3,4 (post type = 1)
@property (strong, nonatomic) NSString <Optional>*food_name; // post type = 2
@property (strong, nonatomic) NSNumber <Optional>*number_serving; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*energy; //post type = 2
@property (strong, nonatomic) NSString <Optional>*protien; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*carbohydrate; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*fiber; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*sugars; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*sodium; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*cholesterol; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*trans; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*saturated; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*monounsaturated; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*polyunsaturated; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*vitamin_a; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*vitamin_b6; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*vitamin_b12; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*vitamin_c; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*thiamin; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*riboflavin; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*niacin; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*folate; //post type = 2
@property (strong, nonatomic) NSNumber <Optional>*time; //post type = 3
@property (strong, nonatomic) NSNumber <Optional>*distance; //post type = 3
@property (strong, nonatomic) NSNumber <Optional>*calories_burned; //post type = 3
@property (strong, nonatomic) NSNumber <Optional>*speed; //post type = 3
@property (strong, nonatomic) NSNumber <Optional>*activity_id; //post type = 3
@property (strong, nonatomic) NSNumber <Optional>*exercise_mets_id; //post type = 3

/*
 access_token	STRING	Y
 content	STRING	N	post type = 1
 post_type	INTEGER	Y	1 = share,2 = food, 3 = excercise
 image	FILE	N
 hashtag	STRING	N	#food #calories
 location_name	STRING	N
 lat	DOUBLE	N
 lng	DOUBLE	N
 share_post_id	INTEGER	N	post type = 1
 share_user_id	INTEGER	N	post type = 1
 user_friend_id	STRING	N	2,3,4 (post type = 1)
 food_name	STRING	Y	post type = 2
 number_serving	INTEGER	Y	post type = 2
 energy	DOUBLE	Y	post type = 2
 protien	DOUBLE	N	post type = 2
 carbohydrate	DOUBLE	N	post type = 2
 fiber	DOUBLE	N	post type = 2
 sugars	DOUBLE	N	post type = 2
 sodium	DOUBLE	N	post type = 2
 cholesterol	DOUBLE	N	post type = 2
 trans	DOUBLE	N	post type = 2
 saturated	DOUBLE	N	post type = 2
 monounsaturated	DOUBLE	N	post type = 2
 polyunsaturated	DOUBLE	N	post type = 2
 vitamin_a	DOUBLE	N	post type = 2
 vitamin_b6	DOUBLE	N	post type = 2
 vitamin_b12	DOUBLE	N	post type = 2
 vitamin_c	DOUBLE	N	post type = 2
 thiamin	DOUBLE	N	post type = 2
 riboflavin	DOUBLE	N	post type = 2
 niacin	DOUBLE	N	post type = 2
 folate	DOUBLE	N	post type = 2
 time	DOUBLE	Y	post type = 3
 distance	DOUBLE	Y	post type = 3
 calories_burned	DOUBLE	Y	post type = 3
 speed	DOUBLE	Y	post type = 3
 activity_id	INTEGER	Y	post type = 3
 exercise_mets_id	INTEGER	Y	post type = 3
 */
@end
