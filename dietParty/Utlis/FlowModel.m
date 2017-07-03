//
//  FlowModel.m
//  dietParty
//
//  Created by Komsit choosangthong on 2/16/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "FlowModel.h"

@implementation FlowModel
#pragma mark - Singleton
+ (FlowModel *)sharedInstance {
    static FlowModel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}
@end
