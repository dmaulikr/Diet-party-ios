//
//  PostModel.m
//  dietParty
//
//  Created by Komsit on 1/10/2559 BE.
//  Copyright © 2559 Komsit. All rights reserved.
//

#import "PostModel.h"
#import "ActivitiesModelRequest.h"
#import "Constants.h"
#import "UsersModel.h"
#import "PostFeedModelRequest.h"
#import "CheerupModelRequest.h"
#import "CommentRequest.h"
#import "PostCommentRequest.h"
#import "GetuserModelRequest.h"
#import "UnCheerupModelRequest.h"


@implementation PostModel

- (void)getPeopleTokenId:(NSString *)token
                     Limit:(NSInteger)limit
                    Offset:(NSInteger)offset
                completion:(void(^)(id success))completion {
    GetuserModelRequest *model = [[GetuserModelRequest alloc] init];
    model.access_token = token;
    model.limit = [NSNumber numberWithInteger:limit];
    model.offset = [NSNumber numberWithInteger:offset];
    [self sendGETRequest:model.toDictionary
                   toUrl:[NSString stringWithFormat:@"%@api/posts/people",CDWebServiceURL]
             WithSuccess:^(id responseObject) {
                 completion(responseObject);
             }];
}

- (void)postFoodwithhashtag:(NSString *)hashtag
            withDescription:(NSString *)desc
                  withImage:(UIImage *)image
               withFoodName:(NSString *)foodname
                    Success:(SuccessResultBlock_t)success {
    
    PostFeedModelRequest *model = [[PostFeedModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    model.desc = desc;
    model.post_type = [NSNumber numberWithInteger:2];
    model.hashtag = hashtag;
    model.food_name = foodname;
    model.number_serving = [NSNumber numberWithInteger:55];
    model.energy = [NSNumber numberWithInteger:250];
    
    [self sendUploadRequest:model.toDictionary
                  imagePath:image
                      toUrl:[NSString stringWithFormat:@"%@api/posts",CDWebServiceURL]
                    Success:^(id responseObject) {
                        NSError *error;
                        BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                        //ResultJSONModel *model = responseObject;
                        success(model);
                    }];
}


- (void)postExercisewithTime:(NSNumber *)time
            withDistance:(NSNumber *)distance
                  withCaloriesBurned:(NSNumber *)calories_burned
               withSpeed:(NSNumber *)speed
             withActivity_id:(NSNumber *)activity_id
        withExercise_mets_id:(NSNumber *)exercise_mets_id
                    Success:(SuccessResultBlock_t)success {
    
    PostFeedModelRequest *model = [[PostFeedModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    model.post_type = [NSNumber numberWithInt:3];
    model.time = time;
    model.distance = distance;
    model.calories_burned = calories_burned;
    model.speed = speed;
    model.activity_id = activity_id;
    model.exercise_mets_id = exercise_mets_id;
    
    [self sendPOSTRequest:model.toDictionary toUrl:[NSString stringWithFormat:@"%@api/posts",CDWebServiceURL] WithSuccess:^(id responseObject) {
        NSError *error;
        BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
        //ResultJSONModel *model = responseObject;
        success(model);
    }];
}



- (void)cheerupWithPostID:(NSNumber *)postID
                    Success:(SuccessResultBlock_t)success {
    
    CheerupModelRequest *model = [[CheerupModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    model.post_id = postID;
    
    [self sendPOSTRequest:model.toDictionary
                    toUrl:[NSString stringWithFormat:@"%@api/cheerups/store",CDWebServiceURL]
              WithSuccess:^(id responseObject) {
                  NSError *error;
                  BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                  //ResultJSONModel *model = responseObject;
                  success(model);
              }];
}

- (void)uncheerupWithPostID:(NSNumber *)postID
                  Success:(SuccessResultBlock_t)success {
    
    UnCheerupModelRequest *model = [[UnCheerupModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    
    [self sendDELETERequest:model.toDictionary
                      toUrl:[NSString stringWithFormat:@"%@api/cheerups/%@",CDWebServiceURL,[postID stringValue]]
                WithSuccess:^(id responseObject) {
                    NSError *error;
                    BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                    //ResultJSONModel *model = responseObject;
                    success(model);
    }];
}

- (void)postCommentWithPostID:(NSNumber *)postID
                      comment:(NSString *)comment
                  Success:(SuccessResultBlock_t)success {
    
    PostCommentRequest *model = [[PostCommentRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    model.post_id = postID;
    model.comment = comment;
    
    [self sendPOSTRequest:model.toDictionary
                    toUrl:[NSString stringWithFormat:@"%@api/comments/store",CDWebServiceURL]
              WithSuccess:^(id responseObject) {
                  NSError *error;
                  BaseJSONModel *model = [[BaseJSONModel alloc] initWithDictionary:responseObject error:&error];
                  //ResultJSONModel *model = responseObject;
                  success(model);
              }];
}

- (void)getCommentWithPostID:(NSNumber *)postID
                  completion:(void(^)(id success))completion {
    
    CommentRequest *model = [[CommentRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    model.limit = [NSNumber numberWithInt:99];
    model.offset = [NSNumber numberWithInt:0];
    [self sendGETRequest:model.toDictionary
                    toUrl:[NSString stringWithFormat:@"%@api/comments/%@",CDWebServiceURL, [postID stringValue]]
              WithSuccess:^(id responseObject) {
                  completion(responseObject);
              }];
}

- (void)getSearchFoodKeyword:(NSString *)keyword
                  completion:(void(^)(SearchFoodNdbnoModelResponse *success))completion {
    NSString *apiKey = @"ODIJZ7ilEqL9OSsCW9KhMCtX8sKP3i55KnBbGsHQ";
    NSString *url = [NSString stringWithFormat:@"%@ndb/search/?format=json&q=%@&sort=n&max=100&offset=0&api_key=%@",DPAPI_USDA,keyword,apiKey];
    [self sendGETRequest:nil toUrl:url WithSuccess:^(id responseObject) {
        NSError *error;
        SearchFoodNdbnoModelResponse *model = [[SearchFoodNdbnoModelResponse alloc] initWithDictionary:responseObject[@"list"] error:&error];
        if (!error) {
            completion(model);
        } else {
            completion(nil);
        }
        
    }];
}

- (void)getReportsFoodKeyword:(NSString *)ndbno
                  completion:(void(^)(SearchFoodNdbnoModelResponse *success))completion {
    NSString *apiKey = @"ODIJZ7ilEqL9OSsCW9KhMCtX8sKP3i55KnBbGsHQ";
    NSString *url = [NSString stringWithFormat:@"%@ndb//reports/?ndbno=%@&type=f&format=json&api_key=%@",DPAPI_USDA,ndbno,apiKey];
    [self sendGETRequest:nil toUrl:url WithSuccess:^(id responseObject) {
        NSError *error;
        SearchFoodNdbnoModelResponse *model = [[SearchFoodNdbnoModelResponse alloc] initWithDictionary:responseObject[@"list"] error:&error];
        if (!error) {
            completion(model);
        } else {
            completion(nil);
        }
        
    }];
}

- (void)getActivitiescompletion:(void(^)(id success))completion {
    ActivitiesModelRequest *model = [[ActivitiesModelRequest alloc] init];
    model.access_token = [UsersModel loadUserInfomaton:uKTokenID];
    
    [self sendGETRequest:model.toDictionary
                      toUrl:[NSString stringWithFormat:@"%@api/activities",CDWebServiceURL]
                WithSuccess:^(id responseObject) {
                    completion(responseObject);
                }];
}
@end
