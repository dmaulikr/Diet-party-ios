//
//  BaseModel.m
//  dietParty
//
//  Created by Komsit choosangthong on 11/25/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "BaseModel.h"

#define uKtimeoutInterval 120
@implementation BaseModel
- (void)sendPOSTRequest:(NSDictionary *)data
              toUrl:(NSString *)url
            WithSuccess:(CompletionBlock_t)success {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = uKtimeoutInterval;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url
       parameters:data
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"responseObject POST:%@",responseObject);
              success(responseObject);
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"AFHTTPRequestOperation POST:%@",error);
              success(nil);
        
          }
     ];
}

- (void)sendGETRequest:(NSDictionary *)data
                  toUrl:(NSString *)url
           WithSuccess:(CompletionBlock_t)success {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = uKtimeoutInterval;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:url parameters:data success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"responseObject GET:%@",responseObject);
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"AFHTTPRequestOperation GET:%@",error);
        success(nil);
    }];
}

- (void)sendPUTRequest:(NSDictionary *)data
                 toUrl:(NSString *)url
           WithSuccess:(CompletionBlock_t)success {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = uKtimeoutInterval;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager PUT:url parameters:data success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"responseObject PUT:%@",responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"AFHTTPRequestOperation PUT:%@",error);
        success(nil);
    }];
}

- (void)sendDELETERequest:(NSDictionary *)data
                 toUrl:(NSString *)url
           WithSuccess:(CompletionBlock_t)success {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = uKtimeoutInterval;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager DELETE:url parameters:data success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"responseObject DELETE:%@",responseObject);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"AFHTTPRequestOperation DELETE:%@",error);
        success(nil);
    }];
}

- (void)sendUploadRequest:(NSDictionary *)data
                imagePath:(UIImage *)image
                    toUrl:(NSString *)url
                  Success:(CompletionBlock_t)success {
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    manager.requestSerializer.timeoutInterval = uKtimeoutInterval;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperation *op = [manager POST:url parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(nil);
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];
}
@end
