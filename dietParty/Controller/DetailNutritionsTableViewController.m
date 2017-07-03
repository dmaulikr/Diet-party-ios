//
//  DetailNutritionsTableViewController.m
//  dietParty
//
//  Created by Komsit choosangthong on 11/1/15.
//  Copyright © 2015 Komsit. All rights reserved.
//

#import "DetailNutritionsTableViewController.h"

@interface DetailNutritionsTableViewController ()
{
    NSArray *tileItem;
}
@end

@implementation DetailNutritionsTableViewController
- (void)setup {
    [self setTitle:NSLocalizedString(@"Nutritions", @"")];
    tileItem = [[NSArray alloc] initWithObjects:@"BREAKFAST",@"LUNCH",@"DINNER", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setUpBarButtonItemBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup ButtonBar Item
- (void)setUpBarButtonItemBack {
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic-arrow-back.png"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(backAction)];
    [self.navigationItem setLeftBarButtonItem:backButton];
    
}

#pragma mark - Event
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 40)];
    [label setFont:[UIFont fontWithName:@"SukhumvitSet-Medium" size:14]];
    NSString *string = NSLocalizedString(tileItem[section], @"");
    /* Section header is in 0th index... */
    //
    switch (section) {
        case 0:
            [label setTextAlignment:NSTextAlignmentLeft];
            [label setTextColor:[UIColor colorWithRed:255/255.0 green:92/255.0 blue:113/255.0 alpha:1]];
            break;
        case 1:
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setTextColor:[UIColor colorWithRed:252/255.0 green:171/255.0 blue:82/255.0 alpha:1]];
            break;
            
        default:
            [label setTextAlignment:NSTextAlignmentRight];
            [label setTextColor:[UIColor colorWithRed:65/255.0 green:155/255.0 blue:249/255.0 alpha:1]];
            break;
    }
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    UITextView *textView = (UITextView *)[cell viewWithTag:110001];
    [textView setText:@"แซนวิชไก่สับผักรวม (ขนมปัง 3 แผ่น สันในไก่ต้มสุกสับ ผสมกับน้ำสลัด ½ ช้อนโต๊ะ ผสมข้าวโพด ถั่วลันเตาและ แครอทตามชอบ) กาแฟร้อน หรือ นมพร่องมันเนยร้อน"];
    // Configure the cell...
    
    return cell;
}



@end
