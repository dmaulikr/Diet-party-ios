//
//  SuccessDiaryViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 10/20/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "SuccessDiaryViewController.h"

@interface SuccessDiaryViewController ()

@end

@implementation SuccessDiaryViewController
- (void)setup {
    [self setTitle:NSLocalizedString(@"Success diary", @"")];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"SuccessDiaryToDetail" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
