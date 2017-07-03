//
//  CommentDetailJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 2/27/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "BaseJSONModel.h"

@interface CommentDetailJSONModel : BaseJSONModel
@property (strong, nonatomic) NSString <Optional>*id;
@property (strong, nonatomic) NSString <Optional>*comment;
@property (strong, nonatomic) NSString <Optional>*created_at;
@property (strong, nonatomic) NSString <Optional>*first_name;
@property (strong, nonatomic) NSString <Optional>*last_name;
@property (strong, nonatomic) NSString <Optional>*profile_image_path;
/*
 "id": "4",
 "comment": "ทดสอบ2 1546456456234234",
 "created_at": "2016-01-26 21:31:09",
 "first_name": "Ong",
 "last_name": "Chusangthong",
 "profile_image_path": "https://graph.facebook.com/1087098871340292/picture?type=large"
 */
@end
