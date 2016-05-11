//
//  ViewController.m
//  AcronymsFinder
//
//  Created by vikas voruganti on 5/10/16.
//  Copyright © 2016 vikas voruganti. All rights reserved.
//

#import "ViewController.h"
#import "AbbreviationTableViewController.h"
#import "AbbreviationService.h"
#import "MBProgressHUD.h"

#define kNavigationTitle @"Acronyms Finder"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField; 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.clearsOnBeginEditing = YES;
    self.textField.delegate = self;
    self.title = kNavigationTitle;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self clearTextFieldText];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)didTapClickHereForAcronyms:(id)sender {
    
    [self abbreviationListForEnteredText:self.textField.text];
    
}

-(void)abbreviationListForEnteredText:(NSString *)inputText {
    
    [self.textField resignFirstResponder];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AbbreviationService *abbSer = [[AbbreviationService alloc]init];
    
        [abbSer getAbbreviationListForGivenWord:inputText completion:^(NSArray *abbreviationList, Service_Status Status) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (Status == Service_Success) {
                [self showAbbreviationListController:abbreviationList];
            } else {
                [self showAlert];
            }
        } andFailure:^(NSError *error, Service_Status Status) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"%@",error.userInfo);
        }];
}

-(void)showAbbreviationListController:(NSArray *)array {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AbbreviationTableViewController *tableController = [storyboard instantiateViewControllerWithIdentifier:@"AbbreviationTableController"];
    tableController.abbrList = array;
    [self.navigationController pushViewController:tableController animated:YES];
}

-(void)showAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert" message:@"No Data Available" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self clearTextFieldText];
    }];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)clearTextFieldText {
    
    self.textField.text = @"";
    
}

#pragma mark - UITextField Delegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [self abbreviationListForEnteredText:self.textField.text];
    return YES;
}

@end
