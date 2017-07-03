//
//  EatImageCommentViewCell.h
//  dietParty
//
//  Created by komsit on 9/27/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EatImageCommentViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bgCellView;
@property (strong, nonatomic) IBOutlet UIButton *cheerButton;
@property (strong, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *cheerupCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareCountLabel;

// Comment
@property (weak, nonatomic) IBOutlet UIImageView *avatarCommentImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeCommentLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentContentTextView;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@end
