//
//  viewShadow.m
//  dietParty
//
//  Created by komsit on 9/20/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "viewShadow.h"

@implementation viewShadow

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }
    return self;
}

- (void)setup {
    //[[self layer] setCornerRadius:10];
    //[[self layer] setBorderWidth:1];
    //[[self layer] setBorderColor:[UIColor grayColor].CGColor];
    [[self layer] setShadowColor:[[UIColor grayColor] CGColor]];
    [[self layer] setShadowOpacity:1];
    [[self layer] setShadowOffset:CGSizeMake(0, 1)];
    [[self layer] setShadowRadius:0.5];
}

@end
