//
//  MealDetailTableViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 2/2/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "MealDetailTableViewController.h"

@interface MealDetailTableViewController ()

@end

@implementation MealDetailTableViewController
- (void)setup {
    [self setTitle:NSLocalizedString(@"Add food", @"")];
}

#pragma mark - Setup ButtonBar Item
- (void)setUpBarButtonItemBack {
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic-arrow-back.png"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(backAction)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
}

- (void)setUpBarButtonItemSelect {
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic-ok-button.png"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(selectAction)];
    [self.navigationItem setRightBarButtonItem:backButton];
    
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)selectAction {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setUpBarButtonItemBack];
    [self setUpBarButtonItemSelect];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
