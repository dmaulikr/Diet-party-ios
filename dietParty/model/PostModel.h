//
//  PostModel.h
//  dietParty
//
//  Created by Komsit on 1/10/2559 BE.
//  Copyright © 2559 Komsit. All rights reserved.
//

#import "BaseModel.h"
#import "BaseJSONModel.h"
#import "SearchFoodNdbnoModelResponse.h"
#import "CommentDetailJSONModel.h"

typedef void (^SuccessResultBlock_t)(BaseJSONModel *model);
@interface PostModel : BaseModel
- (void)getPeopleTokenId:(NSString *)token
                   Limit:(NSInteger)limit
                  Offset:(NSInteger)offset
              completion:(void(^)(id success))completion;

- (void)postFoodwithhashtag:(NSString *)hashtag
            withDescription:(NSString *)desc
                  withImage:(UIImage *)image
               withFoodName:(NSString *)foodname
                    Success:(SuccessResultBlock_t)success;

- (void)postExercisewithTime:(NSNumber *)time
                withDistance:(NSNumber *)distance
          withCaloriesBurned:(NSNumber *)calories_burned
                   withSpeed:(NSNumber *)speed
             withActivity_id:(NSNumber *)activity_id
        withExercise_mets_id:(NSNumber *)exercise_mets_id
                     Success:(SuccessResultBlock_t)success;

- (void)cheerupWithPostID:(NSNumber *)postID
                  Success:(SuccessResultBlock_t)success;

- (void)uncheerupWithPostID:(NSNumber *)postID
                    Success:(SuccessResultBlock_t)success;

- (void)getCommentWithPostID:(NSNumber *)postID
                  completion:(void(^)(id success))completion;

- (void)postCommentWithPostID:(NSNumber *)postID
                      comment:(NSString *)comment
                      Success:(SuccessResultBlock_t)success;

- (void)getSearchFoodKeyword:(NSString *)keyword
                  completion:(void(^)(SearchFoodNdbnoModelResponse *success))completion;

- (void)getActivitiescompletion:(void(^)(id success))completion;
@end
