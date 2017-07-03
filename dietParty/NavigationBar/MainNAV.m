//
//  MainNAV.m
//  dietParty
//
//  Created by komsit on 9/9/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "MainNAV.h"

@interface MainNAV ()

@end

@implementation MainNAV
- (void)setup {
    /*
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:52/255.0 green:199/255.0 blue:255/255.0 alpha:1]];
    //[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setClipsToBounds:NO];
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:52/255.0 green:199/255.0 blue:255/255.0 alpha:1]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new]
                                       forBarMetrics:UIBarMetricsDefault];
    
    
    //[UINavigationBar appearance].shadowImage = [UIImage new];
    [UINavigationBar appearance].translucent = NO;
     */
    
    // New
    [self.navigationBar setBackgroundColor:[UIColor colorWithRed:52/255.0 green:199/255.0 blue:255/255.0 alpha:1]];
    [self.navigationBar setClipsToBounds:NO];
    
    [self.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:52/255.0 green:199/255.0 blue:255/255.0 alpha:1]];
    
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.navigationBar setBackgroundImage:[UIImage new]
                                       forBarMetrics:UIBarMetricsDefault];

    [self.navigationBar setTranslucent:NO];
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
