//
//  FlowModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 2/16/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivitieJSONModel.h"

@interface FlowModel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) id objectData;
@property (strong, nonatomic) ActivitieJSONModel *activitieData;

+ (FlowModel *)sharedInstance;
@end
