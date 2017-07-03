//
//  CustomPushSegue.m
//  dietParty
//
//  Created by komsit on 8/30/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "CustomPushSegue.h"

@implementation CustomPushSegue
- (void)perform {
    UIViewController *source = (UIViewController *) self.sourceViewController;
    UIViewController *destination = (UIViewController *) self.destinationViewController;
    [source.navigationController pushViewController:destination animated:YES];
}
@end
