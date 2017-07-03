//
//  BaseModel.h
//  dietParty
//
//  Created by Komsit choosangthong on 11/25/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "JSONModel.h"

typedef void (^CompletionBlock_t)(id responseObject);
typedef void (^SuccessBlock_t)(JSONModel *model);
typedef void (^FailureBlock_t)(NSError *error);

@interface BaseModel : NSObject

@property (nonatomic, copy) CompletionBlock_t completionBlock;
@property (nonatomic, copy) SuccessBlock_t successBlock;
@property (nonatomic, copy) FailureBlock_t failureBlock;

- (void)sendPOSTRequest:(NSDictionary *)data
                  toUrl:(NSString *)url
            WithSuccess:(CompletionBlock_t)success;

- (void)sendGETRequest:(NSDictionary *)data
                 toUrl:(NSString *)url
           WithSuccess:(CompletionBlock_t)success;

- (void)sendPUTRequest:(NSDictionary *)data
                 toUrl:(NSString *)url
           WithSuccess:(CompletionBlock_t)success;

- (void)sendDELETERequest:(NSDictionary *)data
                    toUrl:(NSString *)url
              WithSuccess:(CompletionBlock_t)success;

- (void)sendUploadRequest:(NSDictionary *)data
                imagePath:(UIImage *)image
                    toUrl:(NSString *)url
                  Success:(CompletionBlock_t)success;

@end
