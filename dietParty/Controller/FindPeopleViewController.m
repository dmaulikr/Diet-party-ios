//
//  FindPeopleViewController.m
//  dietParty
//
//  Created by komsit on 9/24/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "FindPeopleViewController.h"
#import "UsersModel.h"
#import "UpdateWeightViewController.h"
#import "SearchPeopleTableViewCell.h"
#import "EatImageViewCell.h"
#import "PostModel.h"
#import "UsersModel.h"
#import "CountJSONModel.h"
#import "CheerupJSONModel.h"
#import "FeedUserJSONModel.h"
#import "FeedJSONModel.h"
#import "FriendsJSONModel.h"
#import "EatingViewController.h"
#import "EatImageViewCell.h"
#import "ExcerciseViewCell.h"
#import "EatImageCommentViewCell.h"
#import "ExerciseViewController.h"
#import "CommentViewController.h"
#import "UpdateWeightViewController.h"
#import "FeedPostJSONModel.h"
#import "CommentJSONModel.h"
#import "UsersModel.h"
#import "Utlis.h"

#import <SDWebImage/UIImageView+WebCache.h>
//1 = share,2 = food, 3 = excercise

#define shareID 1
#define foodID 2
#define excerciseID 3

//Get List
#define LimitData 20

#define heightForRowComment 647
#define heightForRowImage 513

static NSString *indentifier = @"EatImageViewCell";
static NSString *indentifierComment = @"EatImageCommentViewCell";
static NSString *indentifierExcercise = @"ExcerciseViewCell";
static NSString *indentifierSearchPeople = @"SearchPeopleTableViewCell";

@interface FindPeopleViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listFeed;
    NSMutableArray *friends;
    BOOL isSearch;
}


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FindPeopleViewController
- (void)setup {
    isSearch = NO;
    listFeed = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:indentifier bundle:nil] forCellReuseIdentifier:indentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:indentifierComment bundle:nil] forCellReuseIdentifier:indentifierComment];
    
    [self.tableView registerNib:[UINib nibWithNibName:indentifierExcercise bundle:nil] forCellReuseIdentifier:indentifierExcercise];
    [self.tableView registerNib:[UINib nibWithNibName:indentifierSearchPeople bundle:nil] forCellReuseIdentifier:indentifierSearchPeople];
    
    PostModel *postModel = [[PostModel alloc] init];
    [postModel getPeopleTokenId:[UsersModel loadUserInfomaton:uKTokenID]
                          Limit:100
                         Offset:0
                     completion:^(id success) {
                         if(![success isEqual:[NSNull null]]) {
                             listFeed = success;
                             NSLog(@"success : %@",success);
                         }
                         
                         [self.tableView reloadData];
    }];
}

- (void)getFriends {
    friends = [[NSMutableArray alloc] init];
    UsersModel *usersModel = [[UsersModel alloc] init];
    [usersModel getMyFriendsCompletion:^(id success) {
        friends = success;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self getFriends];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (isSearch) {
        return friends.count;
    }
    return listFeed.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isSearch) {
        return 150;
    } else {
        //Eating
        FeedPostJSONModel *model = [self loadDataForCell:indexPath.row];
        NSLog(@"model : %@",model);
        NSLog(@"Model Data  : %@",listFeed[indexPath.row]);
        
        switch ([model.post.post_type integerValue]) {
            case shareID:
            case foodID: {
                if ([model.count.comment integerValue] != 0) {
                    return heightForRowComment;
                }
            }
                return heightForRowImage;
                break;
            case excerciseID:
                return 220;
                break;
                
            default:
                break;
        }
        return 400;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EatImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    EatImageCommentViewCell *cellComment = [tableView dequeueReusableCellWithIdentifier:indentifierComment];
    ExcerciseViewCell *cellExcercise = [tableView dequeueReusableCellWithIdentifier:indentifierExcercise];
    SearchPeopleTableViewCell *cellSearchPeople = [tableView dequeueReusableCellWithIdentifier:indentifierSearchPeople];
    
    if (cell != nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cellComment = [tableView dequeueReusableCellWithIdentifier:indentifierComment];
        cellExcercise = [tableView dequeueReusableCellWithIdentifier:indentifierExcercise];
        cellSearchPeople = [tableView dequeueReusableCellWithIdentifier:indentifierSearchPeople];
    }
    
    if (isSearch) {
        
        FriendsJSONModel *model = [self loadDataFriendForCell:indexPath.row];
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:model.profile_image_path]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    // do something with image
                                    [[cellSearchPeople profileImaeView] setImage:image];
                                }
                            }];
        
        [[cellSearchPeople fullNameLabel] setText:[NSString stringWithFormat:@"%@ %@",model.first_name,model.last_name]];
        [[cellSearchPeople bodyFatLabel] setText:model.body_fat];
        [[cellSearchPeople weightLossLabel] setText:model.weight_loss];
        
        return cellSearchPeople;
    } else {
        FeedPostJSONModel *model = [self loadDataForCell:indexPath.row];
        //[model.post.identity integerValue]
        
        NSLog(@"model FeedPostJSONModel:%@",model.post.identity);
        
        
        
        [[cell followButton] setHidden:NO];
        [[cellComment followButton] setHidden:NO];
        [[cellExcercise followButton] setHidden:NO];
        
        //timeLabel
        //created_at
        [cell.timeLabel setText:model.post.created_at];
        [cellComment.timeLabel setText:model.post.created_at];
        [cellExcercise.timeLabel setText:model.post.created_at];
        
        [cell.commentButton setTag:[model.post.identity integerValue]];
        [cellComment.commentButton setTag:[model.post.identity integerValue]];
        [cellExcercise.commentButton setTag:[model.post.identity integerValue]];
        [[cell followButton] setTag:[model.user.identity integerValue]];
        [[cellComment followButton] setTag:[model.user.identity integerValue]];
        [[cellExcercise followButton] setTag:[model.user.identity integerValue]];
        
        [[cell commentButton] addTarget:self action:@selector(commentEvent:) forControlEvents:UIControlEventTouchUpInside];
        [[cellComment commentButton] addTarget:self action:@selector(commentEvent:) forControlEvents:UIControlEventTouchUpInside];
        [[cellExcercise commentButton] addTarget:self action:@selector(commentEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [[cell followButton] addTarget:self action:@selector(followEvent:) forControlEvents:UIControlEventTouchUpInside];
        [[cellComment followButton] addTarget:self action:@selector(followEvent:) forControlEvents:UIControlEventTouchUpInside];
        [[cellExcercise followButton] addTarget:self action:@selector(followEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell.cheerButton setTag:[model.post.identity integerValue]];
        cell.cheerButton.selected = !model.cheerup.status;
        
        [cellComment.cheerButton setTag:[model.post.identity integerValue]];
        cellComment.cheerButton.selected = !model.cheerup.status;
        
        [cellExcercise.cheerButton setTag:[model.post.identity integerValue]];
        cellExcercise.cheerButton.selected = !model.cheerup.status;
        if (model.cheerup.status) {
            //[cell likeButton:nil];
            [cell.cheerButton setImage:[UIImage imageNamed:@"ic-Like-select.png"] forState:UIControlStateNormal];
            [cellComment.cheerButton setImage:[UIImage imageNamed:@"ic-Like-select.png"] forState:UIControlStateNormal];
            [cellExcercise.cheerButton setImage:[UIImage imageNamed:@"ic-Like-select.png"] forState:UIControlStateNormal];
        } else {
            [cell.cheerButton setImage:[UIImage imageNamed:@"ic-Like-unselect.png"] forState:UIControlStateNormal];
            [cellComment.cheerButton setImage:[UIImage imageNamed:@"ic-Like-unselect.png"] forState:UIControlStateNormal];
            [cellExcercise.cheerButton setImage:[UIImage imageNamed:@"ic-Like-unselect.png"] forState:UIControlStateNormal];
        }
        //User
        NSLog(@"model.user :%@",model.user);
        [cell.nameLabel setText:[NSString stringWithFormat:@"%@ %@",model.user.first_name, model.user.last_name]];
        [cellComment.nameLabel setText:[NSString stringWithFormat:@"%@ %@",model.user.first_name, model.user.last_name]];
        [cellExcercise.nameLabel setText:[NSString stringWithFormat:@"%@ %@",model.user.first_name, model.user.last_name]];
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:model.user.profile_image_path]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    // do something with image
                                    [[cell avatarImageView] setImage:image];
                                    [[cellComment avatarImageView] setImage:image];
                                    [[cellExcercise avatarImageView] setImage:image];
                                }
                            }];
        
        [manager downloadImageWithURL:[NSURL URLWithString:model.post.image_path]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                if (image) {
                                    // do something with image
                                    [[cell postImageView] setImage:image];
                                    [[cellComment postImageView] setImage:image];
                                }
                            }];
        NSString *des = @"";
        NSString *hashtag = @"";
        NSString *postContent = @"";
        //des
        if ([model.post.desc length] > 0) {
            des = model.post.desc;
        }
        
        if ([model.post.hashtag length] > 0) {
            hashtag = model.post.hashtag;
        }
        
        if ([model.post.content length] > 0) {
            postContent = model.post.content;
        }
        
        switch ([model.post.post_type integerValue]) {
            case shareID: {
                if ([model.count.comment integerValue] != 0) {
                    [[cellComment commentTextView] setText:[NSString stringWithFormat:@"%@ %@ %@",des,postContent,hashtag]];
                    [[cellComment cheerupCountLabel] setText:model.count.cheerup];
                    [[cellComment commentCountLabel] setText:model.count.comment];
                    [[cellComment shareCountLabel] setText:model.count.share];
                    
                    [[cellComment commentContentTextView] setText:model.comment.comment];
                    return cellComment;
                }
                [[cell commentTextView] setText:[NSString stringWithFormat:@"%@ %@ %@",des,postContent,hashtag]];
                [[cell cheerupCountLabel] setText:model.count.cheerup];
                [[cell commentCountLabel] setText:model.count.comment];
                [[cell shareCountLabel] setText:model.count.share];
                return cell;
            }
                
                break;
            case foodID:{
                if ([model.count.comment integerValue] != 0) {
                    [[cellComment commentTextView] setText:[NSString stringWithFormat:@"%@ %@ %@",des,postContent,hashtag]];
                    [[cellComment cheerupCountLabel] setText:model.count.cheerup];
                    [[cellComment commentCountLabel] setText:model.count.comment];
                    [[cellComment shareCountLabel] setText:model.count.share];
                    
                    [[cellComment commentContentTextView] setText:model.comment.comment];
                    return cellComment;
                }
                [[cell commentTextView] setText:[NSString stringWithFormat:@"%@ %@ %@",des,postContent,hashtag]];
                [[cell cheerupCountLabel] setText:model.count.cheerup];
                [[cell commentCountLabel] setText:model.count.comment];
                [[cell shareCountLabel] setText:model.count.share];
                return cell;
            }
                break;
            case excerciseID: {
                [[cellExcercise contentTextView] setText:[NSString stringWithFormat:@"%@ %@",postContent,hashtag]];
                [[cellExcercise cheerupCountLabel] setText:model.count.cheerup];
                [[cellExcercise commentCountLabel] setText:model.count.comment];
                [[cellExcercise shareCountLabel] setText:model.count.share];
                return cellExcercise;
            }
                break;
                
            default:
                break;
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearch = YES;
    [self.tableView reloadData];
    NSLog(@"searchBarTextDidBeginEditing");
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length != 0) {
        isSearch = YES;
    } else {
        isSearch = NO;
    }
    NSLog(@"Search textDidChange");
    
    [self.tableView reloadData];
    // [self.tblContentList reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
    isSearch = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    
}

#pragma mark LoadData
- (FeedPostJSONModel *)loadDataForCell:(NSInteger)index {
    NSError *error;
    return [[FeedPostJSONModel alloc] initWithDictionary:listFeed[index] error:&error];
}

- (FriendsJSONModel *)loadDataFriendForCell:(NSInteger)index {
    NSError *error;
    return [[FriendsJSONModel alloc] initWithDictionary:friends[index] error:&error];
}

- (IBAction)updateWeightEvent:(UIBarButtonItem *)sender {
    
}

#pragma mark Event
- (void)commentEvent:(UIButton *)sender {
    CommentViewController *commentController = [[CommentViewController alloc] init];
    commentController.postID = [NSNumber numberWithInteger:sender.tag];
    [self presentViewController:commentController animated:YES completion:nil];
}

- (void)followEvent:(UIButton *)sender {
    UsersModel *model = [[UsersModel alloc] init];
    NSString *userID = [NSString stringWithFormat:@"%li",sender.tag];
    [model followWithUserID:userID Success:^(BaseJSONModel *model) {
        //[self setup];
    }];
}
- (IBAction)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
    if (self.searchBar.text.length != 0) {
        isSearch = YES;
    } else {
        isSearch = NO;
    }
    [self.tableView reloadData];
}

@end
