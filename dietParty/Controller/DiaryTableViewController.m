//
//  DiaryTableViewController.m
//  dietParty
//
//  Created by komsit on 9/16/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "DiaryTableViewController.h"
#import "UpdateWeightViewController.h"


#define kGKHeaderHeight 150.f
#define kGKHeaderVisibleThreshold 44.f
#define kGKNavbarHeight 64.f
@interface DiaryTableViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottomConstraint;

@end

@implementation DiaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)updateWeightEvent:(UIBarButtonItem *)sender {
    [self presentViewController:[[UpdateWeightViewController alloc] init] animated:YES completion:nil];
}

#pragma mark UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollOffsetY = kGKHeaderHeight-scrollView.contentOffset.y;
    [UIView animateWithDuration:0.3 animations:^{
        // Stretch the header view if neccessary
        if (scrollOffsetY > kGKHeaderHeight) {
            self.imageTopConstraint.constant = kGKHeaderHeight-scrollOffsetY;
        } else {
            self.imageTopConstraint.constant = (kGKHeaderHeight-scrollOffsetY)/2.f;
            self.imageBottomConstraint.constant = -(kGKHeaderHeight-scrollOffsetY)/2.f;
        }
        
                // Show or hide the navigaiton bar
//                if (scrollOffsetY-kGKNavbarHeight < kGKHeaderVisibleThreshold) {
//                    self.navigaionBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityVisible;
//                } else {
//                    self.navigaionBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityHidden;
//                }
    }];
    
}

@end
