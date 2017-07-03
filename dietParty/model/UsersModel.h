//
//  UsersModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 11/25/15.
//  Copyright © 2015 Komsit. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseModel.h"
#import "BaseJSONModel.h"
#import "UserModelResponse.h"
#import "SignInModelResponse.h"
#import "FeedPostJSONModel.h"

#define DPAPI_USDA @"http://api.nal.usda.gov/"

typedef void (^SuccessResultBlock_t)(BaseJSONModel *model);
typedef void (^SuccessUserBlock_t)(UserModelResponse *model);

// KEY For User
#define uKcurrentUser @"uKcurrentUser"
#define uKTokenID @"tokenID"
@interface UsersModel : BaseModel

#pragma mark Update data to device
+ (void)updateUserInfomaton:(NSString *)value forKey:(NSString *)kValue;

+ (void)updateUserInfomaton:(NSArray *)value forArray:(NSString *)kValue;

+ (void)updateUserInfomaton:(NSData *)value forData:(NSString *)kValue;

+ (void)updateUserInfomaton:(NSMutableDictionary *)value forDictionary:(NSString *)kValue;

+ (id)loadUserInfomaton:(NSString *)kValue;

+ (void)logOut;

#pragma mark Register
- (void)registerUsersFirstName:(NSString *)firstName
                  withLastName:(NSString *)lastName
                     withEmail:(NSString *)email
                  withPassword:(NSString *)password
                       Success:(SuccessResultBlock_t)success;

#pragma mark SignIn
- (void)SignInUserwithEmail:(NSString *)username
               withPassword:(NSString *)password
                 completion:(void(^)(SignInModelResponse *success))completion;

#pragma mark GetUser
- (void)GetUserTokenId:(NSString *)token
               Success:(SuccessUserBlock_t)success;

#pragma mark Upload ImageProfil
- (void)uploadImageProfileImage:(UIImage *)image
                     completion:(void(^)(BaseJSONModel *success))completion;

#pragma mark Upload Image Cover
- (void)uploadImageCoverImage:(UIImage *)image
                   completion:(void(^)(BaseJSONModel *success))completion;

#pragma mark Logout
- (void)logoutUserTokenId:(NSString *)token
               completion:(void(^)(BaseJSONModel *success))completion;

#pragma mark SignIn Facebook
- (void)signInWithFBFromViewController:(UIViewController *)viewController completion:(void(^)(id success))completion;

#pragma mark UpdateWeight
- (void)updateWeightUserTokenId:(NSString *)token
                     withWeight:(NSString *)weight
                   withbody_fat:(NSString *)body_fat
                     completion:(void(^)(BaseJSONModel *success))completion;

#pragma mark FeedPost
- (void)GetFeedPostTokenId:(NSString *)token
                     Limit:(NSInteger)limit
                    Offset:(NSInteger)offset
                completion:(void(^)(id success))completion;

#pragma mark UpdateUser
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
                     Success:(SuccessResultBlock_t)success;

- (void)followWithUserID:(NSString *)userID
                 Success:(SuccessResultBlock_t)success;

- (void)unfollowsWithPostID:(NSString *)userID
                    Success:(SuccessResultBlock_t)success;
- (void)getMyFriendsCompletion:(void(^)(id success))completion;
@end
