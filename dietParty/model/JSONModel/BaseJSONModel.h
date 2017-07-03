//
//  BaseJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 11/25/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class CommentJSONModel;
@interface BaseJSONModel : JSONModel
@property (assign, nonatomic) int status;
@property (strong, nonatomic) NSString <Optional>*url;
@end
