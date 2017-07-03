//
//  FoodListTableViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 1/31/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "FoodListTableViewController.h"
#import "FoodListTileViewController.h"
#import "SearchFoodNdbnoModelResponse.h"
#import "FoodNdbnoJSONModel.h"
#import "MBProgressHUD.h"
#import "PostModel.h"
#import "FlowModel.h"

@interface FoodListTableViewController ()
{
    NSArray *itemData;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation FoodListTableViewController
- (void)setup {
    FoodListTileViewController *foodListTileVC = [[FoodListTileViewController alloc] init];
    foodListTileVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FoodListTileViewController"];
    //[self addChildViewControllerView:foodListTileVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildViewControllerView:(UIViewController *)controller {
    [controller.view setFrame:self.view.bounds];
    [self addChildViewController:controller]; // 1
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self]; // 3
}

- (void)removeChildViewControllerView:(UIViewController *)controller {
    [self  willMoveToParentViewController:nil]; // 1
    [self.view removeFromSuperview]; // 2
    [self  removeFromParentViewController]; // 3
}

#pragma mark - searchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"searchBarTextDidBeginEditing :%@",[searchBar text]);
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"searchBarTextDidEndEditing :%@",[searchBar text]);
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"textDidChange :%@",searchText);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [searchBar resignFirstResponder];
    PostModel *postModel = [[PostModel alloc] init];
    [postModel getSearchFoodKeyword:[searchBar text]
                         completion:^(SearchFoodNdbnoModelResponse *success) {
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             itemData = success.item;
                             [self.tableView reloadData];
        
    }];
    // Do the search...
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    FoodNdbnoJSONModel *model = itemData[indexPath.row];
    [[cell textLabel] setText:model.name];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FoodNdbnoJSONModel *model = itemData[indexPath.row];
    [FlowModel sharedInstance].name = model.name;
    [self performSegueWithIdentifier:@"SearchToDetail" sender:self];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Event
- (IBAction)closeEvent:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
