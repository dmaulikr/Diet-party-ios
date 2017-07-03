//
//  ServiceModel.m
//  dietParty
//
//  Created by Somruthai on 10/1/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel
+ (ServiceModel *)sharedInstance
{
    // 1
    static ServiceModel *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[ServiceModel alloc] init];
    });
    return _sharedInstance;
}
@end
