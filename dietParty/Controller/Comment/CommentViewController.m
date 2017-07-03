//
//  CommentViewController.m
//  dietParty
//
//  Created by komsit on 9/27/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentViewCell.h"
#import "CommentDetailJSONModel.h"
#import "MessageTextView.h"
#import "PostModel.h"
#import "RDRGrowingTextView.h"
#import <SDWebImage/UIImageView+WebCache.h>
static CGFloat const MaxToolbarHeight = 200.0f;

CGFloat _currentKeyboardHeight = 0.0f;
static NSString *MessengerCellIdentifier = @"CommentViewCell";
@interface CommentViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
{
    CGSize sc;
    NSMutableArray *item;
}

@property (weak, nonatomic) IBOutlet UITableView *_tableview;
@property (weak, nonatomic) IBOutlet UIView *inputToolbar;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottomLayoutGuide;
@end

@implementation CommentViewController
@synthesize inputToolbar;


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    sc = [[UIScreen mainScreen] bounds].size;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    //[self setup];
    // Do any additional setup after loading the view from its nib.
}

- (void)setup {
    //[self._tableview addSubview:self.inputToolbar];
    self.inputToolbar.layer.zPosition = 1;
}

- (void)loadData {
    item = [[NSMutableArray alloc] init];
    PostModel *postModel = [[PostModel alloc] init];
    [postModel getCommentWithPostID:self.postID completion:^(id success) {
        item = success;
        self._tableview.reloadData;
    }];
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
    return item.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Eating
    return 134;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    static NSString *indentifier = @"CommentViewCell";
    CommentViewCell *cell = [self._tableview dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        
        [tableView registerNib:[UINib nibWithNibName:indentifier bundle:nil] forCellReuseIdentifier:indentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
    }
    
    [cell.nameLabel setText:[NSString stringWithFormat:@"%@ %@",item[indexPath.row][@"first_name"],item[indexPath.row][@"last_name"]]];
    [cell.timeLabel setText:item[indexPath.row][@"created_at"]];
    [cell.commentLabel setText:item[indexPath.row][@"comment"]];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:item[indexPath.row][@"profile_image_path"]]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                // do something with image
                                [cell.avatarImageView setImage:image];
                            }
                        }];
    /*
     @property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
     @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *timeLabel;
     @property (weak, nonatomic) IBOutlet UILabel *commentLabel;
     */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //CGFloat deltaHeight = kbSize.height - _currentKeyboardHeight;
    _currentKeyboardHeight = kbSize.height;
    // Assign new frame to your view
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0,-kbSize.height,sc.width,sc.height)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    }];
    
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setFrame:CGRectMake(0,0,sc.width,sc.height)];
    }];
    
}

#pragma mark - Event
- (IBAction)closeEvent:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postCommentEvent:(UIButton *)sender {
    [self.view endEditing:YES];
    //postCommentWithPostID
    PostModel *postModel = [[PostModel alloc] init];
    [postModel postCommentWithPostID:self.postID
                             comment:self.commentTextView.text
                             Success:^(BaseJSONModel *model) {
                                 self.commentTextView.text = @"";
                                 [self loadData];
    }];
}

- (void)scrollToDow:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    [self._tableview scrollToRowAtIndexPath:indexPath
                   atScrollPosition:UITableViewScrollPositionBottom
                           animated:animated];
    
}

- (CommentDetailJSONModel *)dataForCell:(NSInteger)indx {
    NSError *error;
    CommentDetailJSONModel *model = [[CommentDetailJSONModel alloc] initWithDictionary:item.mutableCopy error:&error];
    if (!error) {
        return model;
    }
    return nil;
}
@end
