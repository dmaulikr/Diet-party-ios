//
//  SignInViewController.m
//  dietParty
//
//  Created by komsit on 8/29/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "SignInViewController.h"
#import "MBProgressHUD.h"
#import "UsersModel.h"
#import "SignInModelResponse.h"
#import "SignInNAV.h"


@interface SignInViewController ()

@end

@implementation SignInViewController
- (void)setup {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Welcome"]]];
}

- (void)authen {
    [self.view setAlpha:0];
    NSString *access_token = [UsersModel loadUserInfomaton:uKTokenID];
    
    if (![access_token isEqualToString:@""] && [access_token length] > 10) {
        [self performSegueWithIdentifier:@"authenToFeed" sender:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self authen];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view setAlpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark Event
- (IBAction)buttonRegisterEvent:(UIButton *)sender {
    
}
- (IBAction)facebookEvent:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UsersModel *usersModel = [[UsersModel alloc] init];
    [usersModel signInWithFBFromViewController:self completion:^(id success) {
        NSLog(@"success facebookEvent :%@",success);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (success != nil) {
            NSError *error;
            SignInModelResponse *modelSignInModel = [[SignInModelResponse alloc] initWithDictionary:success error:&error];
            if ([modelSignInModel.access_token length] != 0) {
                [usersModel GetUserTokenId:modelSignInModel.access_token
                                   Success:^(UserModelResponse *model) {
                                       NSLog(@"SignInEvent model GetUserTokenId:%@",model);
                                       [UsersModel updateUserInfomaton:modelSignInModel.access_token forKey:uKTokenID];
                                       [UsersModel updateUserInfomaton:model.toJSONData forData:uKcurrentUser];
                                       [self performSegueWithIdentifier:@"authenToFeed" sender:self];
                                   }];
            } else {
                [self alertViewTile:@"Error" withMessage:@"not connect"];
            }
            
        } else {
            [self alertViewTile:@"Error" withMessage:@"fb error"];
        }
    }];
}

#pragma mark AlertView
- (void)alertViewTile:(NSString *)tile
          withMessage:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(tile, @"")
                                                        message:NSLocalizedString(msg, @"")
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"button_OK", @"")
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
