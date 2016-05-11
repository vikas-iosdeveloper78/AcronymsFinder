//
//  AbbreviationTableViewController.m
//  AcronymsFinder
//
//  Created by vikas voruganti on 5/10/16.
//  Copyright © 2016 vikas voruganti. All rights reserved.
//

#import "AbbreviationTableViewController.h"
#import "AbbreviationTableViewCell.h"

#define kCellHeight 60.0

@interface AbbreviationTableViewController ()

@end


@implementation AbbreviationTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.abbrList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AbbreviationTableViewCell *cell = (AbbreviationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    if (cell == nil) {
        if (cell == nil) {
            cell = [[AbbreviationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
        }
    }
    
    cell.abbreviationLbl.text = [self.abbrList objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kCellHeight;
    
}

@end
