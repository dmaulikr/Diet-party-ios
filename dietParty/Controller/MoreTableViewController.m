//
//  MoreTableViewController.m
//  dietParty
//
//  Created by komsit on 9/24/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "MoreTableViewController.h"
#import "SignInViewController.h"
#import "UsersModel.h"
#import "UserModelResponse.h"
#import "MBProgressHUD.h"
#import "UpdateWeightViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kGKHeaderHeight 150.f
#define kGKHeaderVisibleThreshold 44.f
#define kGKNavbarHeight 64.f
#define MAX_LENGTH 5

@interface MoreTableViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, UIViewControllerPreviewingDelegate, UITextFieldDelegate>
{
    UIButton *currentButton;
    UILongPressGestureRecognizer *_longPress;
}

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *fullNameCell;
@property (weak, nonatomic) IBOutlet UILabel *emailCell;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextField *youTargetTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UITextField *activityTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITableViewCell *changePasswordCell;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
@property (weak, nonatomic) IBOutlet UITextField *birthDayTextField;

// image Cover
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBottomConstraint;


@end

@implementation MoreTableViewController
@synthesize coverImageView;
@synthesize fullNameCell;
@synthesize emailCell;
@synthesize profileImageView;
@synthesize youTargetTextField;
@synthesize weightTextField;
@synthesize genderTextField;
@synthesize birthDayTextField;
@synthesize activityTextField;
@synthesize heightTextField;
@synthesize changePasswordCell;
@synthesize maleButton;
@synthesize femaleButton;

- (void)setup {
    NSError *error;
    UserModelResponse *model = [[UserModelResponse alloc] initWithData:[UsersModel loadUserInfomaton:uKcurrentUser] error:&error];
    NSLog(@"model UserModelResponse %@",model);
    [fullNameCell setText:[NSString stringWithFormat:@"%@ %@",model.first_name,model.last_name]];
    [emailCell setText:model.email];
    [youTargetTextField setText:model.weight_target];
    [weightTextField setText:model.weight_current];
    [genderTextField setText:model.gender];
    [birthDayTextField setText:model.birthday];
    [activityTextField setText:[model.activity stringValue]];
    [heightTextField setText:model.height];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [birthDayTextField setInputView:datePicker];
    
    //Image Profile
    [self loadImage:profileImageView withURL:model.profile_image_path];
    [self loadImage:coverImageView withURL:model.cover_image_path];
    
    if ([model.facebook_id length] != 0) {
        [changePasswordCell setHidden:YES];
    }
    
    if ([model.gender isEqualToString:@"m"]) {
        [maleButton setImage:[UIImage imageNamed:@"icon-dot-select.png"] forState:UIControlStateNormal];
    } else {
        [femaleButton setImage:[UIImage imageNamed:@"icon-dot-select.png"] forState:UIControlStateNormal];
    }
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
                                [self.tableView reloadData];
                            }
                        }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

#pragma mark - TextField
- (void)textFieldDidEndEditing:(UITextField *)textField {
    UsersModel *userModel = [[UsersModel alloc] init];
    [userModel updateUsersFirstName:nil
                       withLastName:nil
                          withEmail:nil
                       withPassword:nil
                         withWeight:[NSNumber numberWithFloat:[[weightTextField text] floatValue]]
                         withHeight:[NSNumber numberWithFloat:[[heightTextField text] floatValue]]
                         withGender:nil
                       withBirthday:birthDayTextField.text
                       withActivity:nil
                        withBodyFat:nil
                   withWeightTarget:[NSNumber numberWithFloat:[[youTargetTextField text] floatValue]]
                            Success:^(BaseJSONModel *model) {NSLog(@"model update :%@",model);
                                [self getUserInfo];
                            }];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    switch (indexPath.section) {
        case 1:
            if (indexPath.row == 2  && changePasswordCell.hidden) {
                return 0;
            }
            
            break;
            
        default:
            break;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)logOutEvent:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *tokenID = [UsersModel loadUserInfomaton:uKTokenID];
    UsersModel *user = [[UsersModel alloc] init];
    [user logoutUserTokenId:tokenID
                 completion:^(BaseJSONModel *success) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if (success.status == 200) {
#warning logout not work
                         [UsersModel logOut];
                         [self dismissViewControllerAnimated:YES completion:nil];
                     }
                 }];
    [UsersModel logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

#pragma mark Event
- (IBAction)userImageEvent:(UIButton *)sender {
    currentButton= sender;
    [self menuActionSheet];
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
        
//        // Show or hide the navigaiton bar
//        if (scrollOffsetY-kGKNavbarHeight < kGKHeaderVisibleThreshold) {
//            self.navigaionBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityVisible;
//        } else {
//            self.navigaionBarVisibility = GKFadeNavigationControllerNavigationBarVisibilityHidden;
//        }
    }];
    
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    [picker setSourceType:type];
    [picker setAllowsEditing:YES];
    //picker.userInteractionEnabled == YES
    //picker.view.userInteractionEnabled = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    UsersModel *usersModel = [[UsersModel alloc] init];
    switch (currentButton.tag) {
        case 1: {
            // image profile
            [profileImageView setImage:chosenImage];
            
            [usersModel uploadImageProfileImage:chosenImage
                                     completion:^(BaseJSONModel *success) {
                                         NSLog(@"uploadImageProfileImage success :%@",success);
                                         [self getUserInfo];
                                     }];
        }
            
            break;
            
        default: {
            // image cover
            [coverImageView setImage:chosenImage];
            [usersModel uploadImageCoverImage:chosenImage
                                   completion:^(BaseJSONModel *success) {
                                       NSLog(@"uploadImageProfileImage success :%@",success);
                                       [self getUserInfo];
                                   }];
        }
            
            break;
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UIActionSheetDelegate
- (void)menuActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Choose Image", @"")
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"Camera Roll", @"") ,NSLocalizedString(@"Take Photo", @""), nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex :%lo",buttonIndex);
    switch (buttonIndex) {
        case 0:
            [self imagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case 1:
            [self imagePickerController:UIImagePickerControllerSourceTypeCamera];
            break;
        default:
            break;
    }
}

- (IBAction)updateWeightEvent:(UIBarButtonItem *)sender {
    [self presentViewController:[[UpdateWeightViewController alloc] init] animated:YES completion:nil];
}

- (void)getUserInfo {
     NSString *strToken = [UsersModel loadUserInfomaton:uKTokenID];
    UsersModel *usersModel = [[UsersModel alloc] init];
    [usersModel GetUserTokenId:strToken
                       Success:^(UserModelResponse *model) {
                           NSLog(@"SignInEvent model GetUserTokenId:%@",model);
                           [UsersModel updateUserInfomaton:model.toJSONData forData:uKcurrentUser];
                       }];
}
- (IBAction)genderEvent:(UIButton *)sender {
    NSString *gender;
    if (sender == maleButton) {
        //maleButton = m
        gender = @"m";
    } else {
        //femaleButton = f
        gender = @"f";
        
    }
    
    UsersModel *userModel = [[UsersModel alloc] init];
    [userModel updateUsersFirstName:nil
                       withLastName:nil
                          withEmail:nil
                       withPassword:nil
                         withWeight:nil
                         withHeight:nil
                         withGender:gender
                       withBirthday:nil
                       withActivity:nil
                        withBodyFat:nil
                   withWeightTarget:[NSNumber numberWithFloat:[[youTargetTextField text] floatValue]]
                            Success:^(BaseJSONModel *model) {NSLog(@"model update :%@",model);
                                [self getUserInfo];
                            }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [maleButton setImage:[UIImage imageNamed:@"icon-dot.png"] forState:UIControlStateNormal];
        [femaleButton setImage:[UIImage imageNamed:@"icon-dot.png"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"icon-dot-select.png"] forState:UIControlStateNormal];
    }];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == youTargetTextField
        || textField == weightTextField
        || textField == heightTextField) {
        return textField.text.length >= MAX_LENGTH && range.length == 0 ? NO:YES;
    }
    return YES;
    
}
- (IBAction)birthdayChange:(UITextField *)sender {
    [sender setText:@"TEST"];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)birthDayTextField.inputView;
    birthDayTextField.text = [self formatDate:picker.date];
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
     NSString *formattedDate = [dateFormatter stringFromDate:date];
     return formattedDate;
     }

@end
