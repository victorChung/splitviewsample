//
//  UserDefaultsViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/17.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "UserDefaultsViewController.h"

@interface UserDefaultsViewController ()

@end

@implementation UserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    UITextField *txtField=[[UITextField alloc]init];
    txtField.borderStyle=UITextBorderStyleRoundedRect;
    
    [self.view addSubview:txtField];
    
    //add Constraint
    txtField.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *txtFieldTop=[NSLayoutConstraint constraintWithItem:txtField attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *txtFieldLeading=[NSLayoutConstraint constraintWithItem:txtField attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *txtFieldTrailing=[NSLayoutConstraint constraintWithItem:txtField attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    
    [NSLayoutConstraint activateConstraints:@[txtFieldTop,txtFieldLeading,txtFieldTrailing]];
    
    
    NSString *usrDef=[[NSUserDefaults standardUserDefaults] objectForKey:@"usrDef"];
    if (usrDef) {
        txtField.text=usrDef;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
