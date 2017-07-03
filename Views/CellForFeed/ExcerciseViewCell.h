//
//  ExcerciseViewCell.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/9/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcerciseViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bgCellView;
@property (strong, nonatomic) IBOutlet UIButton *cheerButton;
@property (strong, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shardButton;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *cheerupCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareCountLabel;
@end
