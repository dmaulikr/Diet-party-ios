//
//  FoodNdbnoJSONModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 2/2/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface FoodNdbnoJSONModel : JSONModel
@property (strong, nonatomic) NSNumber *offset;
@property (strong, nonatomic) NSString <Optional>*group;
@property (strong, nonatomic) NSString <Optional>*name;
@property (strong, nonatomic) NSNumber *ndbno;
/*
 offset: 0,
 group: "Baby Foods",
 name: "Babyfood, apples with ham, strained",
 ndbno: "03289"
 */
@end
