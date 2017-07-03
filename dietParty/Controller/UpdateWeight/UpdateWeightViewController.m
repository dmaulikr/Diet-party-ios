//
//  UpdateWeightViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 11/1/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "UpdateWeightViewController.h"
#import "Constants.h"
#import "UsersModel.h"
#import "MBProgressHUD.h"
#import "UserModelResponse.h"

#define MAX_LENGTH 5
@interface UpdateWeightViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bodyWeightTextField;
@property (weak, nonatomic) IBOutlet UITextField *bodyFatTextField;

@end

@implementation UpdateWeightViewController
@synthesize bodyFatTextField;
@synthesize bodyWeightTextField;
- (void)setup {
    NSError *error;
    UserModelResponse *model = [[UserModelResponse alloc] initWithData:[UsersModel loadUserInfomaton:uKcurrentUser] error:&error];
    NSLog(@"model UserModelResponse %@",model);
    //[bodyWeightTextField setText:[NSString stringWithFormat:@"%@",model.weight]];
    //[bodyFatTextField setText:[NSString stringWithFormat:@"%@",model.body_fat]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeEvent:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finshEvent:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    UsersModel *usersModel = [[UsersModel alloc] init];
    NSString *token = [UsersModel loadUserInfomaton:uKTokenID];
    [usersModel updateWeightUserTokenId:token
                             withWeight:[bodyWeightTextField text]
                           withbody_fat:[bodyFatTextField text]
                             completion:^(BaseJSONModel *success) {
                                 if (success.status == 200) {
                                     [usersModel GetUserTokenId:token
                                                        Success:^(UserModelResponse *model) {
                                                            [UsersModel updateUserInfomaton:model.toJSONData forData:uKcurrentUser];
                                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                            [self dismissViewControllerAnimated:YES completion:nil];
                                     }];
                                 } else {
                                     // error
                                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                                     [self alertViewTile:@"error" withMessage:[NSString stringWithFormat:@"Error (%i)",success.status]];
                                 }
                             }];
}

- (void)alertViewTile:(NSString *)tile withMessage:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(tile, @"")
                                                        message:NSLocalizedString(msg, @"")
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
    [alertView show];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return textField.text.length >= MAX_LENGTH && range.length == 0 ? NO:YES;
}
@end
