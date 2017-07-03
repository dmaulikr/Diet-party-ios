//
//  SearchPeopleTableViewCell.h
//  dietParty
//
//  Created by Komsit choosangthong on 4/23/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchPeopleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImaeView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyFatLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLossLabel;

@end
