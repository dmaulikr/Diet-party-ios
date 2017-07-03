//
//  Utlis.m
//  dietParty
//
//  Created by Komsit choosangthong on 1/8/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import "Utlis.h"

#define wide 800
#define hight 600

@implementation Utlis
+ (void)downloadImageURL:(NSString *)url
              completion:(void(^)(UIImage *success))completion {
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:url]
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                // progression tracking code
                            }
                           completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                               if (image && finished) {
                                   // do something with image
                                   completion(image);
                               }
                               completion(nil);
                           }];
}

+ (void)loadImage:(NSURL *)URL
    withIndexPath:(NSIndexPath *)indexPath
       completion:(void (^)(UIImage *image, NSIndexPath *indexTarget))completion
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        UIImage *image = [[UIImage alloc] initWithData:responseObject];
        completion(image, indexPath);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
    [operation start];
}

+ (UIImage *)resizeImage:(UIImage *)image {
    CGRect rect = CGRectMake(0,0,wide,hight);
    UIGraphicsBeginImageContext( rect.size );
    [image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(picture1, 0.8);
    return [UIImage imageWithData:imageData];
}
@end
