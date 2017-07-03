//
//  CustomTabbar.m
//  dietParty
//
//  Created by komsit on 9/9/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "CustomTabbar.h"

@interface CustomTabbar ()

@end

@implementation CustomTabbar
- (void)setup {
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SukhumvitSet-Text" size:10], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
     [[UITabBar appearance] setTintColor:[UIColor lightGrayColor]];
    
    
    // Select
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:52/255.0 green:199/255.0 blue:255/255.0 alpha:1] }
                                             forState:UIControlStateSelected];
    
    
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
