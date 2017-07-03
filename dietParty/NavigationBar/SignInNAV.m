//
//  SignInNAV.m
//  dietParty
//
//  Created by komsit on 9/3/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "SignInNAV.h"

@interface SignInNAV ()

@end

@implementation SignInNAV
- (void)setup {
    /*
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setClipsToBounds:YES];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new]
                                       forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].shadowImage = [UIImage new];
    [UINavigationBar appearance].translucent = YES;
     */
    
    
    // New
    [self.navigationBar setBackgroundColor:[UIColor colorWithRed:52/255.0 green:199/255.0 blue:255/255.0 alpha:1]];
    [self.navigationBar setClipsToBounds:NO];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationBar setClipsToBounds:YES];
    
    [self.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    
    [self.navigationBar setBackgroundImage:[UIImage new]
                                       forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setTranslucent:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
