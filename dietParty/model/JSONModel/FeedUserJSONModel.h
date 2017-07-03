//
//  FeedUserJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/26/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@interface FeedUserJSONModel : JSONModel
@property (strong, nonatomic) NSString <Optional>*identity;
@property (strong, nonatomic) NSString <Optional>*first_name;
@property (strong, nonatomic) NSString <Optional>*last_name;
@property (strong, nonatomic) NSString <Optional>*profile_image_path;
/*
 "id": "5",
 "first_name": "Ong",
 "last_name": "Chusangthong",
 "profile_image_path": "https://graph.facebook.com/1087098871340292/picture?type=large"
 */
@end
