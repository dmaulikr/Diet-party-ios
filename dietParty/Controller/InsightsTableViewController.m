//
//  InsightsTableViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 10/19/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "InsightsTableViewController.h"
#import "UsersModel.h"
#import "UserModelResponse.h"
#import "KAProgressLabel.h"

@interface InsightsTableViewController ()
@property (weak,nonatomic) IBOutlet KAProgressLabel * pLabel1;
@property (weak, nonatomic) IBOutlet UILabel *startedLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagetLabel;
@end

@implementation InsightsTableViewController

- (void)setupKAProgressLabel {
    NSError *error;
    UserModelResponse *model = [[UserModelResponse alloc] initWithData:[UsersModel loadUserInfomaton:uKcurrentUser] error:&error];
    
    [self.startedLabel setText:model.weight_result];
    [self.currentLabel setText:model.weight_current];
    [self.tagetLabel setText:model.weight_target];
    
    
    self.pLabel1.backgroundColor = [UIColor clearColor];
    self.pLabel1.trackWidth = 22;
    self.pLabel1.progressWidth = 22;
    self.pLabel1.roundedCornersWidth = 22;
    self.pLabel1.trackColor = [[UIColor grayColor] colorWithAlphaComponent:.2];
    self.pLabel1.progressColor = [UIColor cyanColor];
    self.pLabel1.labelVCBlock = ^(KAProgressLabel *label){
        //self.pLabel1.startLabel.text = [NSString stringWithFormat:@"%.f",self.pLabel1.progress*100];
    };
    self.pLabel1.isEndDegreeUserInteractive = YES;
    
    self.pLabel1.progress = 0;
    
    [self.pLabel1 setProgress:0.8 timing:TPPropertyAnimationTimingEaseInEaseOut duration:5 delay:1.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupKAProgressLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
