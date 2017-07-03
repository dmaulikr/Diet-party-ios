//
//  TextFieldPersen.m
//  dietParty
//
//  Created by Komsit on 12/3/2558 BE.
//  Copyright © 2558 Komsit. All rights reserved.
//

#import "TextFieldPersen.h"

@implementation TextFieldPersen
{
    NSString *row1;
    NSString * row2;
    NSMutableArray *item1;
    NSMutableArray *item2;
}
- (void)myInitialization
{
    // PickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.6]];
    
    
    // label Dot
    UILabel *dotLabel = [[UILabel alloc] initWithFrame:CGRectMake(pickerView.frame.size.width /2, (pickerView.frame.size.height /2)-10, 50, 20)];
    [dotLabel setFont:[UIFont systemFontOfSize:18]];
    [dotLabel setText:NSLocalizedString(@".", @"")];
    [pickerView addSubview:dotLabel];
    
    
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(pickerView.frame.size.width -26, (pickerView.frame.size.height /2)-10, 50, 20)];
    [unitLabel setFont:[UIFont systemFontOfSize:18]];
    [unitLabel setText:NSLocalizedString(@"%", @"")];
    [pickerView addSubview:unitLabel];
    self.inputView = pickerView;
    //self.inputAccessoryView = toolbar;
}

- (void)setupData {
    item1 = [[NSMutableArray alloc] init];
    item2 = [[NSMutableArray alloc] init];
    for (int idx = 0; idx <= 100; idx++) {
        if (idx <= 9) {
            [item2 addObject:[NSString stringWithFormat:@"%i",idx]];
        }
        [item1 addObject:[NSString stringWithFormat:@"%i",idx]];
    }
}

#pragma mark Event
- (void)doneButtonClicked:(id)sender {
    
    [self resignFirstResponder];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self myInitialization];
        [self setupData];
        row1 = @"0";
        row2 = @"0";
        
    }
    
    return self;
}

#pragma mark TextField
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    /*
     if (action == @selector(paste:))
     {
     return true;
     }
     */
    
    return false;
}

#pragma mark UIPickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [item1 count];
            break;
            
        default:
            return [item2 count];;
            break;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    //return [NSString stringWithFormat:@"Choice-%d",row];//Or, your suitable title; like Choice-a, etc.
    switch (component) {
        case 0:
            return item1[row];
            break;
            
        default:
            return item2[row];
            break;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            row1 = item1[row];
            break;
            
        default:
            row2 = item2[row];
            break;
    }
    [self setText:[NSString stringWithFormat:@"%@.%@",row1,row2]];
}

@end
