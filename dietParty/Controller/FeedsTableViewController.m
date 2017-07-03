//
//  FeedsTableViewController.m
//  dietParty
//
//  Created by komsit on 9/9/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "FeedsTableViewController.h"
#import "CountJSONModel.h"
#import "CheerupJSONModel.h"
#import "FeedUserJSONModel.h"
#import "FeedJSONModel.h"
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
#define LimitData 50

#define heightForRowComment 647
#define heightForRowImage 513

static NSString *indentifier = @"EatImageViewCell";
static NSString *indentifierComment = @"EatImageCommentViewCell";
static NSString *indentifierExcercise = @"ExcerciseViewCell";

@interface FeedsTableViewController ()
{
    NSMutableArray *listFeed;
    NSInteger pageIndex;
    BOOL loadIng;
}
@end

@implementation FeedsTableViewController

- (void)setup {
    listFeed = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:indentifier bundle:nil] forCellReuseIdentifier:indentifier];
    
    [self.tableView registerNib:[UINib nibWithNibName:indentifierComment bundle:nil] forCellReuseIdentifier:indentifierComment];
    
    [self.tableView registerNib:[UINib nibWithNibName:indentifierExcercise bundle:nil] forCellReuseIdentifier:indentifierExcercise];
    
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.refreshControl setTintColor:[UIColor colorWithRed:52/255.0 green:199/255.0 blue:225/255.0 alpha:1]];
    // 52 199 225
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];

    UsersModel *model = [[UsersModel alloc] init];
    [model GetFeedPostTokenId:[UsersModel loadUserInfomaton:uKTokenID]
                        Limit:LimitData
                       Offset:0
                   completion:^(id success) {
                       pageIndex = 1;
                       listFeed = success;
                       [self.tableView reloadData];
                   }];
    
    
}

- (void)loadDataIndex:(NSUInteger)index {
    if (loadIng) {
        UsersModel *model = [[UsersModel alloc] init];
        [model GetFeedPostTokenId:[UsersModel loadUserInfomaton:uKTokenID]
                            Limit:LimitData
                           Offset:index
                       completion:^(id success) {
                           if (success != nil) {
                               NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                                      NSMakeRange(0,[listFeed count])];
                               [listFeed insertObjects:[success mutableCopy] atIndexes:indexes];
                               pageIndex++;
                           }
                           loadIng = NO;
                           [self.tableView reloadData];
                       }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    // End the refreshing
    if (self.refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        UsersModel *model = [[UsersModel alloc] init];
        [model GetFeedPostTokenId:[UsersModel loadUserInfomaton:uKTokenID]
                            Limit:LimitData
                           Offset:0
                       completion:^(id success) {
                           listFeed = success;
                           [self.refreshControl endRefreshing];
                           [self.tableView reloadData];
                       }];
    }
}

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
    FeedPostJSONModel *model = [self loadDataForCell:indexPath.row];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EatImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    EatImageCommentViewCell *cellComment = [tableView dequeueReusableCellWithIdentifier:indentifierComment];
    ExcerciseViewCell *cellExcercise = [tableView dequeueReusableCellWithIdentifier:indentifierExcercise];
    
    [[cell followButton] setHidden:YES];
    
    FeedPostJSONModel *model = [self loadDataForCell:indexPath.row];
    //[model.post.identity integerValue]

    NSLog(@"model.comment :%@",model.comment);
    
    if (cell != nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cellComment = [tableView dequeueReusableCellWithIdentifier:indentifierComment];
        cellExcercise = [tableView dequeueReusableCellWithIdentifier:indentifierExcercise];
    }
    
    //timeLabel
    //created_at
    [cell.timeLabel setText:model.post.created_at];
    [cellComment.timeLabel setText:model.post.created_at];
    [cellExcercise.timeLabel setText:model.post.created_at];
    
    [cell.commentButton setTag:[model.post.identity integerValue]];
    [cellComment.commentButton setTag:[model.post.identity integerValue]];
    [cellExcercise.commentButton setTag:[model.post.identity integerValue]];
    
    [[cell commentButton] addTarget:self action:@selector(commentEvent:) forControlEvents:UIControlEventTouchUpInside];
    [[cellComment commentButton] addTarget:self action:@selector(commentEvent:) forControlEvents:UIControlEventTouchUpInside];
    [[cellComment moreButton] addTarget:self action:@selector(commentEvent:) forControlEvents:UIControlEventTouchUpInside];
    [[cellExcercise commentButton] addTarget:self action:@selector(commentEvent:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    // Comment
    [manager downloadImageWithURL:[NSURL URLWithString:model.comment.profile_image_path]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {}
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                [[cellComment avatarCommentImageView] setImage:image];
                            }
                        }];
    [cellComment.nameCommentLabel setText:[NSString stringWithFormat:@"%@ %@",model.comment.first_name,model.comment.last_name]];
    [cellComment.timeCommentLabel setText:model.comment.created_at];
    [cellComment.commentContentTextView setText:model.comment.comment];
    
    NSLog(@"indexPath.row : %li", indexPath.row);
    
    if(indexPath.row == [listFeed count] - 1 ) {
        loadIng = YES;
        [self loadDataIndex:pageIndex];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)eatingEvent:(UIButton *)sender {
    [self presentViewController:[EatingViewController alloc] animated:YES completion:nil];
}
- (IBAction)exerciseEvent:(UIButton *)sender {
    ExerciseViewController *exerciseViewController = [[ExerciseViewController alloc] init];
    [self presentViewController:exerciseViewController animated:YES completion:nil];
}

#pragma mark Event
- (void)commentEvent:(UIButton *)sender {
    CommentViewController *commentController = [[CommentViewController alloc] init];
    commentController.postID = [NSNumber numberWithInteger:sender.tag];
    [self presentViewController:commentController animated:YES completion:nil];
}
- (IBAction)updateWeightEvent:(id)sender {
    
    [self presentViewController:[[UpdateWeightViewController alloc] init] animated:YES completion:nil];
}
- (IBAction)postEvent:(UIButton *)sender {
    [self.tableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark LoadData
- (FeedPostJSONModel *)loadDataForCell:(NSInteger)index {
    NSError *error;
    return [[FeedPostJSONModel alloc] initWithDictionary:listFeed[index] error:&error];
}
@end
