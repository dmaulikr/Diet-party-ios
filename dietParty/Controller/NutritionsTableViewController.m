//
//  NutritionsTableViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 11/1/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "NutritionsTableViewController.h"

@interface NutritionsTableViewController ()

@end

@implementation NutritionsTableViewController
- (void)setup {
    [self setTitle:NSLocalizedString(@"Nutritions", @"")];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setUpBarButtonItemBack];
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

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"nytritionsToDetail" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
