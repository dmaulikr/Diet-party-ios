//
//  SearchFoodNdbnoModelResponse.h
//  dietParty
//
//  Created by Komsit choosangthong on 2/1/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol FoodNdbnoJSONModel;
@interface SearchFoodNdbnoModelResponse : JSONModel
@property (strong, nonatomic) NSNumber *end;
@property (strong, nonatomic) NSString <Optional>*group;
@property (strong, nonatomic) NSArray <FoodNdbnoJSONModel,Optional>*item;
@property (strong, nonatomic) NSString *q;
@property (strong, nonatomic) NSString *sort;
@property (strong, nonatomic) NSString *sr;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSNumber *total;

/*
 q: "ham",
 sr: "28",
 start: 0,
 end: 25,
 total: 154,
 group: "",
 sort: "n",
 item: [
 */

/*
 offset: 0,
 group: "Baby Foods",
 name: "Babyfood, apples with ham, strained",
 ndbno: "03289"
 */
@end
