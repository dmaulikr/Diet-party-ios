//
//  ActivitieJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 3/17/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ActivitieJSONModel : JSONModel
@property (strong, nonatomic) NSString <Optional>*identity;
@property (strong, nonatomic) NSString <Optional>*activity_name;
@end
