//
//  ExerciseViewController.m
//  dietParty
//
//  Created by komsit on 9/28/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "ExerciseViewController.h"
#import "ExerciseListViewController.h"
#import "MBProgressHUD.h"
#import "PostModel.h"
#import "FlowModel.h"

@interface ExerciseViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *sliderScrollView;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *kgTextField;
@property (weak, nonatomic) IBOutlet UITextField *caTextField;

@end

@implementation ExerciseViewController
@synthesize sliderScrollView;
- (void)setup {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [FlowModel sharedInstance].activitieData = nil;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)nextPageByIndex:(int)index {
    CGRect frame = sliderScrollView.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    [sliderScrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)backEvent:(id)sender {
    [self nextPageByIndex:0];
}

- (IBAction)nextEvent:(id)sender {
    [self nextPageByIndex:1];
}
- (IBAction)closeEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)selectEvent:(UIButton *)sender {
    [self presentViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ExerciseListViewController"] animated:YES completion:nil];
}

- (IBAction)sendData:(UIButton *)sender {
    if ([FlowModel sharedInstance].activitieData != nil) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        PostModel *post = [[PostModel alloc] init];
        [post postExercisewithTime:[NSNumber numberWithInt:[self.timeTextField.text intValue]]
                      withDistance:[NSNumber numberWithInt:[self.kgTextField.text intValue]]
                withCaloriesBurned:[NSNumber numberWithInt:[self.caTextField.text intValue]]
                         withSpeed:[NSNumber numberWithInt:5]
                   withActivity_id:[NSNumber numberWithInt:[[FlowModel sharedInstance].activitieData.identity intValue]]
              withExercise_mets_id:[NSNumber numberWithInt:1]
                           Success:^(BaseJSONModel *model) {
                               if (model.status == 200) {
                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                   [self dismissViewControllerAnimated:YES completion:nil];
                               } else {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                                   message:@"Error"
                                                                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                   [alert show];
                               }
                           }];
    }
    
}

@end
