//
//  Utlis.h
//  dietParty
//
//  Created by Komsit choosangthong on 1/8/16.
//  Copyright © 2016 Komsit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SDWebImageDownloader.h"
#import "AFnetworking.h"

@interface Utlis : NSObject
+ (void)downloadImageURL:(NSString *)url
              completion:(void(^)(UIImage *success))completion;

+ (void)loadImage:(NSURL *)URL
    withIndexPath:(NSIndexPath *)indexPath
       completion:(void (^)(UIImage *image, NSIndexPath *indexTarget))completion;

+ (UIImage *)resizeImage:(UIImage *)image;
@end
