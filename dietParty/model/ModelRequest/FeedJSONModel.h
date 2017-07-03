//
//  FeedJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/26/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FeedJSONModel : JSONModel
@property (strong, nonatomic) NSString <Optional>*identity;
@property (strong, nonatomic) NSString <Optional>*content;
@property (strong, nonatomic) NSString <Optional>*desc;
@property (strong, nonatomic) NSString <Optional>*hashtag;
@property (strong, nonatomic) NSString <Optional>*post_type;
@property (strong, nonatomic) NSString <Optional>*image_path;
@property (strong, nonatomic) NSString <Optional>*created_at;
@property (strong, nonatomic) NSString <Optional>*updated_at;
/*
 "id": "20",
 "content": "Ong ate a ทดสอบๆๆๆ",
 "description": "",
 "hashtag": "#food",
 "post_type": "2",
 "image_path": "https://s3-ap-southeast-1.amazonaws.com/dietparty/staging/5/post_1452441948.jpg",
 "created_at": "2016-01-10 23:05:48",
 "updated_at": "2016-01-10 23:05:48"
 */

/*
 post =         {
 content = "Gritsakorn has completed 60 mins exercise Bicycling";
 "created_at" = "2015-12-20 03:58:52";
 description = "";
 hashtag = "#Bike";
 id = 4;
 "image_path" = "https://s3-ap-southeast-1.amazonaws.com/dietparty/staging/1/post_1450558731.png";
 "updated_at" = "2015-12-20 03:58:52";
 };
 */
@end
