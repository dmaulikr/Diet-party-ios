//
//  RegisterViewController.m
//  dietParty
//
//  Created by komsit on 8/30/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "RegisterViewController.h"
#import "UsersModel.h"
#import "MBProgressHUD.h"
#import "ResultJSONModel.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize FirstNameTextField;
@synthesize EmailTextField;
@synthesize PasswordTextField;
@synthesize ConPasswordTextField;

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

#pragma mark - Event
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signInEvent:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"registerToSignInEmail" sender:self];
}

- (IBAction)joinEvent:(id)sender {
    [self.view endEditing:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([[PasswordTextField text] isEqualToString:[ConPasswordTextField text]]) {
        UsersModel *usersModel = [[UsersModel alloc] init];
        [usersModel registerUsersFirstName:[FirstNameTextField text]
                              withLastName:[FirstNameTextField text]
                                 withEmail:[EmailTextField text]
                              withPassword:[PasswordTextField text]
                                   Success:^(BaseJSONModel *model) {
                                       [MBProgressHUD hideHUDForView:self.view animated:YES];
                                       NSLog(@"model :%@",model);
                                       
                                       if (model.status == 200) {
                                           [self.navigationController popViewControllerAnimated:YES];
                                           //[self performSegueWithIdentifier:@"RegisterToHome" sender:self];
                                       } else {
                                           [self alertViewTile:@"Error" withMessage:[NSString stringWithFormat:@"%i",model.status]];
                                       }
                                   }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"", @"")
                                                             message:NSLocalizedString(@"password_error", @"")
                                                            delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"button_OK", @"")
                                                   otherButtonTitles:nil];
        [alertView show];
    }
    
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
@end
