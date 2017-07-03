//
//  EatingViewController.m
//  dietParty
//
//  Created by komsit on 9/27/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "EatingViewController.h"
#import "YCameraViewController.h"
#import "MBProgressHUD.h"
#import "PostModel.h"
#import "MainNAV.h"
#import "FlowModel.h"

#define textviewPlaceholder @"Add description…"
@interface EatingViewController () <UITextViewDelegate, YCameraViewControllerDelegate>
{
    BOOL openCamera;
    UIImage *imageData;
    NSMutableString *tagString;
    NSString *foodName;
}
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageDisplay;
@property (weak, nonatomic) IBOutlet UITextView *foodNameTextView;
@end

@implementation EatingViewController
- (void)setup {
    [FlowModel sharedInstance].name = @"";
    tagString = [[NSMutableString alloc]init];
    [self.view setAlpha:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    if (!openCamera) {
        [self camera];
        //[self performSelector:@selector(camera) withObject:self afterDelay:0];
    }
    foodName = @"";
    if ([FlowModel sharedInstance].name.length != 0) {
        [self.foodNameTextView setText:[FlowModel sharedInstance].name];
        foodName = [FlowModel sharedInstance].name;
    }
}

- (IBAction)closeEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)okEvent:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    PostModel *model = [[PostModel alloc] init];
    [model postFoodwithhashtag:tagString
               withDescription:[self.descriptionTextView text]
                     withImage:imageData
                  withFoodName:foodName
                       Success:^(BaseJSONModel *model) {
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           if (model.status == 200) {
                               [self dismissViewControllerAnimated:YES completion:nil];
                           } else {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                               message:@"Error"
                                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                               [alert show];
                           }
                           
                       }];
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    textView.textColor = [UIColor whiteColor];
}

- (void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor grayColor];
        textView.text = textviewPlaceholder;
        [textView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    textView.textColor = [UIColor blackColor];
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(textView.text.length == 0){
            textView.textColor = [UIColor blackColor];
            //textView.text = textviewPlaceholder;
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}
- (IBAction)shareFacebookEvent:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        if (sender.selected) {
            [sender setImage:[UIImage imageNamed:@"ic-button-facebook-select.png"] forState:UIControlStateNormal];
            sender.selected = NO;
        } else {
            //[self unLikeButton:sender];
            [sender setImage:[UIImage imageNamed:@"ic-button-facebook-unselect.png"] forState:UIControlStateNormal];
            sender.selected = YES;
        }
    }];
    
    
    
}

- (void)camera {
    
    openCamera = YES;
    YCameraViewController *camController = [[YCameraViewController alloc] initWithNibName:@"YCameraViewController" bundle:nil];
    camController.delegate = self;
    [self presentViewController:camController animated:YES completion:^{
        // completion code
        [self.view setAlpha:1];
    }];
}

- (void)didFinishPickingImage:(UIImage *)image {
    imageData = image;
    [self.imageDisplay setImage:image];
}

- (void)yCameraControllerDidCancel {
    
}

- (void)yCameraControllerdidSkipped {
    
}

#pragma mark Event
- (IBAction)nutritionGroupEvent:(UIButton *)sender {
    
    NSString *strTag;
    switch (sender.tag) {
        case 1:
            strTag = @"#Fruits";
            break;
        case 2:
            strTag = @"#Veggies";
            break;
        case 3:
            strTag = @"#Grains";
            break;
        case 4:
            strTag = @"#Protien";
            break;
        case 5:
            strTag = @"#Oils/Fats";
            break;
        case 6:
            strTag = @"#Dairy";
            break;
        case 7:
            strTag = @"#Sweets";
            break;
        case 8:
            strTag = @"#Drinks";
            break;
            
        default:
            break;
    }
    
    NSRange range = [tagString rangeOfString:strTag];
    if (range.location == NSNotFound) {
        NSLog(@"string was not found");
        [tagString appendString:[NSString stringWithFormat:@"%@",strTag]];
    } else {
        NSLog(@"position %lu", (unsigned long)range.location);
        tagString = [[tagString stringByReplacingOccurrencesOfString:strTag withString:@""] mutableCopy];
    }
    
    //tagString = [[tagString stringByReplacingOccurrencesOfString:strTag withString:@""] mutableCopy];
    //1 Fruits
    //2 Veggies
    //3 Grains
    //4 Protien
    //5 Oils/Fats
    //6 Dairy
    //7 Sweets
    //8 Drinks
    NSLog(@"nutritionGroupEvent TAG :%@",tagString);
    
    
}

- (IBAction)tapDetailEvent:(id)sender {
    // Food menu
    MainNAV *foodListTileVC = [[MainNAV alloc] init];
    foodListTileVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FoodListNAV"];
    [self presentViewController:foodListTileVC animated:YES completion:nil];
}

@end
