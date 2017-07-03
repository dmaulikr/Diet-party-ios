//
//  CommentJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 2/27/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CommentJSONModel : JSONModel
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *created_at;
@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString *profile_image_path;



/*
 "id": "8",
 "comment": "มดสอบบบบ",
 "created_at": "2016-03-29 07:49:40",
 "first_name": "Ong",
 "last_name": "Chusangthong",
 "profile_image_path": "https://graph.facebook.com/1087098871340292/picture?type=large"
 */
@end
