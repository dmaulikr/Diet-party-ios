//
//  CustomPresentSegue.m
//  dietParty
//
//  Created by komsit on 8/30/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "CustomPresentSegue.h"

@implementation CustomPresentSegue
- (void)perform {
    UIViewController *source = (UIViewController *) self.sourceViewController;
    UIViewController *destination = (UIViewController *) self.destinationViewController;
    [source presentViewController:destination animated:YES completion:nil];
}
@end
