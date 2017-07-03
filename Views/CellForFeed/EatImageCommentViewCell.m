//
//  EatImageCommentViewCell.m
//  dietParty
//
//  Created by komsit on 9/27/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "EatImageCommentViewCell.h"
#import "PostModel.h"

@implementation EatImageCommentViewCell
@synthesize bgCellView;
@synthesize cheerButton;

- (void)setupBgView {
    [[bgCellView layer] setCornerRadius:10];
    [[bgCellView layer] setBorderWidth:1];
    [[bgCellView layer] setBorderColor:[UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1].CGColor];
}

- (void)awakeFromNib {
    // Initialization code
    [self setupBgView];
    cheerButton.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)CheerEvent:(UIButton *)sender {
    NSLog(@"like");
    PostModel *postModel = [[PostModel alloc] init];
    if (sender.selected) {
        
        [postModel cheerupWithPostID:[NSNumber numberWithInteger:sender.tag]
                             Success:^(BaseJSONModel *model) {}];
        [self likeButton:sender];
        sender.selected = NO;
    } else {
        //[self unLikeButton:sender];
        [postModel uncheerupWithPostID:[NSNumber numberWithInteger:sender.tag]
                               Success:^(BaseJSONModel *model) {}];
        [UIView animateWithDuration:0.3 animations:^{
            [sender setImage:[UIImage imageNamed:@"ic-Like-unselect.png"] forState:UIControlStateNormal];
        }];
        sender.selected = YES;
    }
    
}

- (void)likeButton:(UIButton *)sender {
    [sender setImage:[UIImage imageNamed:@"ic-Like-select.png"] forState:UIControlStateNormal];
    UIImageView *likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(cheerButton.frame.origin.x+2, cheerButton.frame.origin.y+7, cheerButton.imageView.frame.size.width, cheerButton.imageView.frame.size.height)];
    [likeImage setImage:[UIImage imageNamed:@"ic-Like-select.png"]];
    [likeImage setBackgroundColor:[UIColor whiteColor]];
    [likeImage setAlpha:0];
    [bgCellView addSubview:likeImage];
    
    [UIView animateWithDuration:0 animations:^{
        [likeImage setAlpha:0.8];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            CGRect newFrame = likeImage.frame;
            newFrame.origin.y -= 37;
            newFrame.size.height += 15;
            newFrame.size.width += 15;
            [likeImage setFrame:newFrame];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                [likeImage setAlpha:0];
                
            } completion:^(BOOL finished) {
                [likeImage removeFromSuperview];
            }];
        }];
    }];
}

- (void)unLikeButton:(UIButton *)sender {
    UIImageView *likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(cheerButton.frame.origin.x+2, cheerButton.frame.origin.y+7, cheerButton.imageView.frame.size.width, cheerButton.imageView.frame.size.height)];
    [likeImage setImage:[UIImage imageNamed:@"ic-Like-select.png"]];
    [likeImage setBackgroundColor:[UIColor clearColor]];
    [likeImage setAlpha:0];
    [bgCellView addSubview:likeImage];
    
    for (int idx = 0; 2 > idx; idx++) {
        
        [UIView animateWithDuration:0.3 animations:^{
            [likeImage setAlpha:0.8];
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                [sender setImage:[UIImage imageNamed:@"ic-Like-unselect.png"] forState:UIControlStateNormal];
                CGRect newFrame = likeImage.frame;
                newFrame.origin.y -= 20;
                [likeImage setFrame:newFrame];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    [likeImage setAlpha:0];
                    
                } completion:^(BOOL finished) {
                    [likeImage removeFromSuperview];
                }];
            }];
        }];
    }
}

@end
