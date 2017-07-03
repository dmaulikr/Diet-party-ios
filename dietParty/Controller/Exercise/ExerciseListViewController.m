//
//  ExerciseListViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 4/9/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "ExerciseListViewController.h"
#import "ActivitieJSONModel.h"
#import "FlowModel.h"
#import "PostModel.h"
@interface ExerciseListViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listFeed;
}
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@end

@implementation ExerciseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
}

- (void)loadData {
    listFeed = [[NSMutableArray alloc] init];
    PostModel *postModel = [[PostModel alloc] init];
    [postModel getActivitiescompletion:^(id success) {
        NSLog(@"getActivitiescompletion : %@", success);
        listFeed = [success mutableCopy];
        self.tbView.reloadData;
    }];
}

#pragma mark LoadData
- (ActivitieJSONModel *)loadDataForCell:(NSInteger)index {
    NSError *error;
    return [[ActivitieJSONModel alloc] initWithDictionary:listFeed[index] error:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listFeed.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [cell.textLabel setText:[self loadDataForCell:indexPath.row].activity_name];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [FlowModel sharedInstance].activitieData = [self loadDataForCell:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ok:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
