//
//  CommentViewCell.m
//  dietParty
//
//  Created by komsit on 10/1/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "CommentViewCell.h"

@implementation CommentViewCell
@synthesize bgView;
- (void)awakeFromNib {
    // Initialization code
    [self setup];
}

- (void)setup {
    //[[bgView layer] setCornerRadius:10];
    [[bgView layer] setBorderWidth:0.5];
    [[bgView layer] setBorderColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1].CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
