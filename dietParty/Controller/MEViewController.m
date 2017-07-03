//
//  MEViewController.m
//  dietParty
//
//  Created by komsit on 10/1/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "MEViewController.h"
#import "TimelineTableViewController.h"
#import "InsightsTableViewController.h"
#import "UserModelResponse.h"
#import "UsersModel.h"
#import "UpdateWeightViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MEViewController ()
{
    TimelineTableViewController *timeLineView;
    InsightsTableViewController *insightsTableViewController;
    UIButton *currentButton;
    __weak IBOutlet UIImageView *profileImageView;
}
@property (strong, nonatomic) IBOutlet UIView *lineMenuView;
@property (weak, nonatomic) IBOutlet UIButton *timeLineButton;
@property (weak, nonatomic) IBOutlet UIButton *insightsButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scvScrollView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@end

@implementation MEViewController
@synthesize chanelView;
@synthesize scvScrollView;
@synthesize fullNameLabel;
@synthesize coverImageView;

- (void)setup {
    timeLineView = [[TimelineTableViewController alloc] init];
    insightsTableViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InsightsTableViewController"];
    scvScrollView = (UIScrollView *)[self.view viewWithTag:10001];
    for (int idx = 0; 1 >= idx;idx++) {
        UIView *view;
        if (idx == 0) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, scvScrollView.frame.size.height)];
            [timeLineView.view setFrame:view.bounds];
            [view addSubview:timeLineView.view];
        } else {
            view = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width *idx, 0, self.view.frame.size.width, scvScrollView.frame.size.height)];
            [insightsTableViewController.view setFrame:view.bounds];
            [view addSubview:insightsTableViewController.view];
        }
        [scvScrollView addSubview:view];
    }
    
    [self.scvScrollView setContentSize:CGSizeMake(self.view.frame.size.width*2,1)];
    
    // Get data local
    NSError *error;
    UserModelResponse *model = [[UserModelResponse alloc] initWithData:[UsersModel loadUserInfomaton:uKcurrentUser] error:&error];
    NSLog(@"model UserModelResponse %@",model);
    [fullNameLabel setText:[NSString stringWithFormat:@"%@ %@",model.first_name,model.last_name]];

    // Image Profile
    [self loadImage:profileImageView withURL:model.profile_image_path];
    [self loadImage:coverImageView withURL:model.cover_image_path];
}

- (void)loadImage:(UIImageView *)imageView withURL:(NSString *)url {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:url]
                          options:0
                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                             // progression tracking code
                             [imageView setImage:[UIImage imageNamed:@"bg-default-more.png"]];
                         }
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (image) {
                                [imageView setImage:image];
                                // do something with image
                            }
                        }];
}

- (void)addChildViewControllerView:(UIViewController *)controller {
    [controller.view setFrame:self.chanelView.bounds];
    [self addChildViewController:controller]; // 1
    [self.chanelView addSubview:controller.view];
    [controller didMoveToParentViewController:self]; // 3
}

- (void)removeChildViewControllerView:(UIViewController *)controller {
    [self  willMoveToParentViewController:nil]; // 1
    [controller.view removeFromSuperview]; // 2
    [self  removeFromParentViewController]; // 3
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [self nextPageByIndex:0];
}

- (IBAction)menuEvent:(UIButton *)sender {
    if (sender == self.timeLineButton) {
        [self nextPageByIndex:0];
    } else {
        [self nextPageByIndex:1];
    }
    currentButton = sender;
    [self lineToButton:sender];
}


- (void)lineToButton:(UIButton *)button {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect newFrame = self.lineMenuView.frame;
        newFrame.origin.x = button.frame.origin.x;
        newFrame.size.width = button.frame.size.width;
        [self.lineMenuView setFrame:newFrame];
    }];
    
}

- (void)nextPageByIndex:(int)index {
    [scvScrollView setScrollEnabled:YES];
    CGRect frame = scvScrollView.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    [self.scvScrollView scrollRectToVisible:frame animated:YES];
    [scvScrollView setScrollEnabled:NO];
    NSLog(@"frame :%@", NSStringFromCGRect(frame));
}

- (IBAction)updateWeightEvent:(UIBarButtonItem *)sender {
    [self presentViewController:[[UpdateWeightViewController alloc] init] animated:YES completion:nil];
}
@end
