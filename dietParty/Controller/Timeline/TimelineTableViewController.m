//
//  TimelineTableViewController.m
//  dietParty
//
//  Created by komsit on 10/1/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "TimelineTableViewController.h"
#import "UsersModel.h"
#import "FeedJSONModel.h"
#import "TimelineViewCell.h"


#define shareID 1
#define foodID 2
#define excerciseID 3
@interface TimelineTableViewController ()
{
    NSMutableArray *listFeed;
}
@end

@implementation TimelineTableViewController
- (void)setup {
   listFeed = [[NSMutableArray alloc] init];
}

- (void)loadData {
    
    UsersModel *model = [[UsersModel alloc] init];
    [model GetFeedPostTokenId:[UsersModel loadUserInfomaton:uKTokenID]
                        Limit:20
                       Offset:0
                   completion:^(id success) {
                       NSLog(@"GetFeedPostTokenId :%@",success);
                       listFeed = [success mutableCopy];
                       NSLog(@"GetFeedPostTokenId :%@",listFeed);
                       [self.tableView reloadData];
                   }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
    
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [listFeed count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Eating
    return 54;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tableView.frame.size.width, 18)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"SukhumvitSet-Text" size:13]];
    [label setTextColor:[UIColor colorWithRed:198/255.0 green:198/255.0 blue:200/255.0 alpha:1]];
    NSString *string = @"MONDAY, MARCH 14";
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor clearColor]]; //your background color...
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    static NSString *indentifier = @"TimelineViewCell";
    TimelineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    FeedPostJSONModel *model = [self loadDataForCell:indexPath.row];
    
    if (!cell) {
        
        [tableView registerNib:[UINib nibWithNibName:indentifier bundle:nil] forCellReuseIdentifier:indentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
    }
    
    [cell.textTileLabel setText:model.post.content];
    //[cell.timeTextLabel setText:@""];
    
    switch ([model.post.post_type integerValue]) {
        case shareID:
            [cell.desTextLabel setText:@"Share"];
            break;
            case foodID:
            [cell.desTextLabel setText:@"Food"];
            break;
            default:
            [cell.desTextLabel setText:@"Excercise"];
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark LoadData
- (FeedPostJSONModel *)loadDataForCell:(NSInteger)index {
    NSError *error;
    return [[FeedPostJSONModel alloc] initWithDictionary:listFeed[index] error:&error];
}

@end
