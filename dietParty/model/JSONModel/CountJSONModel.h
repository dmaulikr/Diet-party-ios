//
//  CountJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/26/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CountJSONModel : JSONModel
@property (strong, nonatomic) NSString *cheerup;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *share;

/*
 "cheerup": "0",
 "comment": "1",
 "share": "0"
 */
@end
