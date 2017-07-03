//
//  SuccessDiaryDetailViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 10/26/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "SuccessDiaryDetailViewController.h"

@interface SuccessDiaryDetailViewController ()

@end

@implementation SuccessDiaryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)InAppPurchaseEvent:(UIButton *)sender {
    [self performSegueWithIdentifier:@"SuccessToLetStart" sender:self];
}

@end
