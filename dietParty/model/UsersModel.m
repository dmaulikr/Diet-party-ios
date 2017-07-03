//
//  UsersModel.m
//  dietParty
//
//  Created by Komsit choosangthong on 11/25/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "UsersModel.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Constants.h"
#import "SignInRequest.h"
#import "SignInFbModelRequest.h"
#import "GetuserModelRequest.h"
#import "UpdateWeightModelRequest.h"
#import "UsersJSONModel.h"
#import "UploadUserImageModelRequest.h"
#import "UpdateUserModelRequest.h"
#import "FollowModelRequest.h"
#import "UnFollowModelRequest.h"
#import "FriendsModelRequest.h"



@implementation UsersModel

#pragma mark Update data to device
+ (void)updateUserInfomaton:(NSString *)value forKey:(NSString *)kValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:kValue];
    [userDefaults synchronize];
}

+ (void)updateUserInfomaton:(NSArray *)value forArray:(NSString *)kValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:kValue];
    [userDefaults synchronize];
}

+ (void)updateUserInfomaton:(NSData *)value forData:(NSString *)kValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:kValue];
    [userDefaults synchronize];
}

+ (void)updateUserInfomaton:(NSMutableDictionary *)value forDictionary:(NSString *)kValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:kValue];
    [userDefaults synchronize];
}

+ (id)loadUserInfomaton:(NSString *)kValue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:kValue];
    
}

+ (void)logOut
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)registerUsersFirstName:(NSString *)firstName
                  withLastName:(NSString *)lastName
                     withEmail:(NSString *)email
                  withPassword:(NSString *)password
                       Success:(SuccessResultBlock_t)success {
    
    UsersJSONModel *model = [[UsersJSONModel alloc] init];
    model.first_name = firstName;
    model.last_name = lastName;
    model.email = email;
    model.password = password;
    
    [self sendPOSTRequest:model.toDictionary
                    toUrl:[NSString stringWithFormat:@"%@api/register",CDWebServiceURL]
              WithSuccess:^(id responseObject) {
                  NSError *error;
                  BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                  //ResultJSONModel *model = responseObject;
                  success(model);
                  
        
    }];
}

- (void)SignInUserwithEmail:(NSString *)username
                  withPassword:(NSString *)password
                       completion:(void(^)(SignInModelResponse *success))completion {
    
    SignInRequest *model = [[SignInRequest alloc] init];
    model.grant_type = @"password";
    model.client_id = @"OIYT9MWqVMbKFiB8EODK/rCD+rAyQv5IQgCyqu1Y";
    model.client_secret = @"SJbrzEUWlLJaPsGN6pgUX8BmTK9zvHIm7dZdDUa5";
    model.type_login = @"e";
    model.username = username;
    model.password = password;
    
    [self sendPOSTRequest:model.toDictionary
                    toUrl:[NSString stringWithFormat:@"%@api/login",CDWebServiceURL]
              WithSuccess:^(id responseObject) {
                  NSError *error;
                  SignInModelResponse *model = [[SignInModelResponse alloc] initWithDictionary:responseObject error:&error];
                  //ResultJSONModel *model = responseObject;
                  NSLog(@"responseObject UsersModel :%@",model);
                  NSLog(@"ResultJSONModel UsersModel :%@",model.access_token);
                  completion(model);
                  
                  
              }];
}

- (void)GetUserTokenId:(NSString *)token
               Success:(SuccessUserBlock_t)success {
    GetuserModelRequest *model = [[GetuserModelRequest alloc] init];
    model.access_token = token;
    [self sendGETRequest:model.toDictionary
                   toUrl:[NSString stringWithFormat:@"%@api/users",CDWebServiceURL]
             WithSuccess:^(id responseObject) {
                 NSError *error;
                 UserModelResponse *model = [[UserModelResponse alloc] initWithDictionary:responseObject error:&error];
                 NSLog(@"responseObject UsersModel GET:%@",responseObject);
                 if (error) {
                     success(nil);
                 } else {
                     NSLog(@"responseObject UsersModel GET:%@",model);
                     success(model);
                 }
    }];
}

- (void)GetFeedPostTokenId:(NSString *)token
                     Limit:(NSInteger)limit
                     Offset:(NSInteger)offset
               completion:(void(^)(id success))completion {
    GetuserModelRequest *model = [[GetuserModelRequest alloc] init];
    model.access_token = token;
    model.limit = [NSNumber numberWithInteger:limit];
    model.offset = [NSNumber numberWithInteger:offset];
    [self sendGETRequest:model.toDictionary
                   toUrl:[NSString stringWithFormat:@"%@api/posts/feed",CDWebServiceURL]
             WithSuccess:^(id responseObject) {
                 completion(responseObject);
             }];
}

- (void)updateUsersFirstName:(NSString *)firstName
                  withLastName:(NSString *)lastName
                     withEmail:(NSString *)email
                  withPassword:(NSString *)password
                    withWeight:(NSNumber *)weight
                    withHeight:(NSNumber *)height
                    withGender:(NSString *)gender
                  withBirthday:(NSString *)birthday
                  withActivity:(NSNumber *)activity
                   withBodyFat:(NSNumber *)bodyfat
              withWeightTarget:(NSNumber *)weightTarget
                       Success:(SuccessResultBlock_t)success {
    
    UpdateUserModelRequest *model = [[UpdateUserModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    model.first_name = firstName;
    model.last_name = lastName;
    model.email = email;
    model.password = password;
    model.weight = weight;
    model.height = height;
    model.gender = gender;
    model.birthday = birthday;
    model.activity = activity;
    model.body_fat = bodyfat;
    model.weight_target = weightTarget;
    
    [self sendPUTRequest:model.toDictionary
                    toUrl:[NSString stringWithFormat:@"%@api/users/updater",CDWebServiceURL]
              WithSuccess:^(id responseObject) {
                  NSError *error;
                  BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                  //ResultJSONModel *model = responseObject;
                  NSLog(@"responseObject UsersModel :%@",model);
                  NSLog(@"ResultJSONModel UsersModel :%i",model.status);
                  success(model);
                  
                  
              }];
}

#pragma mark Logout
- (void)logoutUserTokenId:(NSString *)token
                  completion:(void(^)(BaseJSONModel *success))completion {
    GetuserModelRequest *model = [[GetuserModelRequest alloc] init];
    model.access_token = token;
    [self sendDELETERequest:model.toDictionary
                   toUrl:[NSString stringWithFormat:@"%@api/logout",CDWebServiceURL]
             WithSuccess:^(id responseObject) {
                 NSError *error;
                 BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                 NSLog(@"responseObject api/logout :%@",model.toJSONString);
                 NSLog(@"responseObject api/logout responseObject:%@",responseObject);
                 completion(model);
                 
             }];
}

#pragma mark Upload ImageProfil
- (void)uploadImageProfileImage:(UIImage *)image
                     completion:(void(^)(BaseJSONModel *success))completion {
    UploadUserImageModelRequest *model = [[UploadUserImageModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    //model.image = image;
    
    
    
    NSLog(@"model.toDictionary :%@",model.toDictionary);
    [self sendUploadRequest:model.toDictionary
                  imagePath:image
                      toUrl:[NSString stringWithFormat:@"%@/api/photos/profile",CDWebServiceURL]
                    Success:^(id responseObject) {
                        NSError *error;
                        BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                        NSLog(@"responseObject api/logout :%@",model.toJSONString);
                        NSLog(@"responseObject api/logout responseObject:%@",responseObject);
                        completion(model);
                    }];
}

#pragma mark Upload Image Cover
- (void)uploadImageCoverImage:(UIImage *)image
                   completion:(void(^)(BaseJSONModel *success))completion {
    UploadUserImageModelRequest *model = [[UploadUserImageModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    //model.image = image;
    
    
    
    NSLog(@"model.toDictionary :%@",model.toDictionary);
    [self sendUploadRequest:model.toDictionary
                  imagePath:image
                      toUrl:[NSString stringWithFormat:@"%@/api/photos/cover",CDWebServiceURL]
                    Success:^(id responseObject) {
                        NSError *error;
                        BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                        NSLog(@"responseObject api/logout :%@",model.toJSONString);
                        NSLog(@"responseObject api/logout responseObject:%@",responseObject);
                        completion(model);
                    }];
}

#pragma mark - Methods
- (void)signInWithFBFromViewController:(UIViewController *)viewController completion:(void(^)(id success))completion {
    NSLog(@"viewController :%@",viewController);
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    //@"public_profile", @"email", @"user_friends"
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]
                 fromViewController:viewController
                            handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                if (error) {
                                    if (self.failureBlock) {
                                        NSLog(@"facebook error :%@",[error description]);
                                        completion(nil);
                                        
                                    }
                                } else if (result.isCancelled) {
                                    // Handle cancellations
                                    completion(nil);
                                    NSLog(@"facebook cancellations");
                                    
                                } else {
                                    FBSDKGraphRequest *fbRequest = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil];
                                    [fbRequest startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                                        if(error) {
                                            //error
                                            completion(nil);
                                        } else {
                                            
                                            SignInFbModelRequest *model = [[SignInFbModelRequest alloc] init];
                                            model.grant_type = @"password";
                                            model.client_id = @"OIYT9MWqVMbKFiB8EODK/rCD+rAyQv5IQgCyqu1Y";
                                            model.client_secret = @"SJbrzEUWlLJaPsGN6pgUX8BmTK9zvHIm7dZdDUa5";
                                            model.type_login = @"f";
                                            model.username = [result valueForKey:@"id"];
                                            model.password = @" ";
                                            
                                            model.first_name = [[[result valueForKey:@"name"] componentsSeparatedByString:@" "] firstObject];
                                            model.last_name = [[[result valueForKey:@"name"] componentsSeparatedByString:@" "] lastObject];
                                            model.email = [result valueForKey:@"email"];
                                            model.profile_image_path = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[result valueForKey:@"id"]];
                                            
                                            NSLog(@"SignInFbModelRequest :%@",model.toJSONString);
                                            [self sendPOSTRequest:model.toDictionary
                                                            toUrl:[NSString stringWithFormat:@"%@api/loginfb",CDWebServiceURL]
                                                      WithSuccess:^(id responseObject) {
                                                          completion(responseObject); 
                                                      }];
                                            
                                            NSLog(@"FB result 1 ;%@",result);
                                            NSLog(@"FB result ;%@",[result valueForKey:@"name"]);
                                            
                                            
                                        }
                                    }];
                                }
                                
                            }];
}

#pragma mark UpdateWeight
- (void)updateWeightUserTokenId:(NSString *)token
                     withWeight:(NSString *)weight
                     withbody_fat:(NSString *)body_fat
               completion:(void(^)(BaseJSONModel *success))completion {
    UpdateWeightModelRequest *model = [[UpdateWeightModelRequest alloc] init];
    
    model.access_token = token;
    model.weight = weight;
    model.body_fat = body_fat;
    
    [self sendPOSTRequest:model.toDictionary
                    toUrl:[NSString stringWithFormat:@"%@api/weight/update",CDWebServiceURL]
              WithSuccess:^(id responseObject) {
                  NSError *error;
                  BaseJSONModel *responseObjectModel = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                  
                  NSLog(@"ResultJSONModel UsersModel :%i",responseObjectModel.status);
                  completion(responseObjectModel);
                  
                  
              }];
}

- (void)followWithUserID:(NSString *)userID
                  Success:(SuccessResultBlock_t)success {
    
    FollowModelRequest *model = [[FollowModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    model.user_follow_id = userID;
    
    [self sendPOSTRequest:model.toDictionary
                    toUrl:[NSString stringWithFormat:@"%@api/follows",CDWebServiceURL]
              WithSuccess:^(id responseObject) {
                  NSError *error;
                  BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                  success(model);
              }];
}

- (void)unfollowsWithPostID:(NSString *)userID
                    Success:(SuccessResultBlock_t)success {
    
    UnFollowModelRequest *model = [[UnFollowModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    
    [self sendDELETERequest:model.toDictionary
                      toUrl:[NSString stringWithFormat:@"%@api/cheerups/%@",CDWebServiceURL,userID]
                WithSuccess:^(id responseObject) {
                    NSError *error;
                    BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                    //ResultJSONModel *model = responseObject;
                    success(model);
                }];
}

- (void)getMyFriendsCompletion:(void(^)(id success))completion  {
    
    FriendsModelRequest *model = [[FriendsModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    model.limit = @"50";
    model.offset = @"0";
    
    [self sendGETRequest:model.toDictionary
                      toUrl:[NSString stringWithFormat:@"%@api/friends",CDWebServiceURL]
                WithSuccess:^(id responseObject) {
                    completion(responseObject);
                }];
}
@end
