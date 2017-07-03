//
//  SignInEmailViewController.m
//  dietParty
//
//  Created by komsit on 9/9/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "SignInEmailViewController.h"
#import "SignInModelResponse.h"
#import "MBProgressHUD.h"
#import "UsersModel.h"

@interface SignInEmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;

@end

@implementation SignInEmailViewController
@synthesize EmailTextField;
@synthesize PasswordTextField;
- (void)setup {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Welcome"]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setUpBarButtonItemBack];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup ButtonBar Item
- (void)setUpBarButtonItemBack {
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic-arrow-back.png"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(backAction)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Event

- (IBAction)createUserEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"SignInToRegister" sender:self];
}

- (IBAction)SignInEvent:(id)sender {
    [self.view endEditing:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UsersModel *usersModel = [[UsersModel alloc] init];
    [usersModel SignInUserwithEmail:[EmailTextField text]
                       withPassword:[PasswordTextField text]
                            completion:^(SignInModelResponse *success) {
                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                NSLog(@"SignInEvent model SignInUserwithEmail:%@",success);
                                if ([success.access_token length] != 0) {
                                    [usersModel GetUserTokenId:success.access_token
                                                       Success:^(UserModelResponse *model) {
                                                           NSLog(@"SignInEvent model GetUserTokenId:%@",model);
                                                           [UsersModel updateUserInfomaton:success.access_token forKey:uKTokenID];
                                                           [UsersModel updateUserInfomaton:model.toJSONData forData:uKcurrentUser];
                                                           [self performSegueWithIdentifier:@"SignInEmailToFeed" sender:self];
                                                           [self.navigationController popToRootViewControllerAnimated:YES];
                                                       }];
                                } else {
                                    [self alertViewTile:@"Error" withMessage:@"not connect"];
                                }
                                
                                
                            }];
}

#pragma mark - UIAlertView
- (void)alertViewTile:(NSString *)tile
          withMessage:(NSString *)msg {
    UIAlertView *aletView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(tile, @"")
                                                        message:NSLocalizedString(msg, @"")
                                                       delegate:self
                                             cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                             otherButtonTitles:nil];
    [aletView show];
}

/*
 [usersModel GetUserTokenId:success.access_token
 Success:^(UserModelResponse *model) {
 NSLog(@"SignInEvent model GetUserTokenId:%@",model);
 [self performSegueWithIdentifier:@"SignInToHome" sender:self];
 }];
 */

@end
