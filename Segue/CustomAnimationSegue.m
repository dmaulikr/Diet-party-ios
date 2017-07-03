//
//  CustomAnimationSegue.m
//  dietParty
//
//  Created by komsit on 8/30/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "CustomAnimationSegue.h"

@implementation CustomAnimationSegue
/*
 CATransition *animation = [CATransition animation];
 animation.delegate = self;
 animation.duration = 0.25f;
 animation.timingFunction = UIViewAnimationCurveEaseInOut;
 animation.fillMode = kCAFillModeForwards;
 animation.removedOnCompletion = NO;
 animation.type = kCATransitionPush;
 animation.subtype = kCATransitionFromTop;
 [bView.view.layer addAnimation:animation forKey:@"animation"];
 
 //add bView to current view
 [self.view addSubview:bView];
 */

- (void)perform {
    UIViewController *source = (UIViewController *) self.sourceViewController;
    UIViewController *destination = (UIViewController *) self.destinationViewController;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.25f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.removedOnCompletion = NO;
    //animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [destination.view.layer addAnimation:animation forKey:@"animation"];
    
    //add bView to current view
    //[destination.view addSubview:source.view];
    [source.navigationController pushViewController:destination animated:NO];
}
@end
