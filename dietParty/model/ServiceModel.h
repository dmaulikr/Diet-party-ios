//
//  ServiceModel.h
//  dietParty
//
//  Created by Somruthai on 10/1/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ServiceModel : NSObject
@property (nonatomic, strong) UIImage *imageData;
+ (ServiceModel *)sharedInstance;

@end
