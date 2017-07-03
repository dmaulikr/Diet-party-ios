//
//  FeedHeaderView.m
//  dietParty
//
//  Created by komsit on 9/9/2558 BE.
//  Copyright (c) 2558 Komsit. All rights reserved.
//

#import "FeedHeaderView.h"

@implementation FeedHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [[self layer] setCornerRadius:10];
    [[self layer] setBorderWidth:1];
    [[self layer] setBorderColor:[UIColor grayColor].CGColor];
    [[self layer] setShadowColor:[[UIColor grayColor] CGColor]];
    [[self layer] setShadowOpacity:1];
    [[self layer] setShadowOffset:CGSizeMake(0, 1)];
    [[self layer] setShadowRadius:0.5];
}
@end
