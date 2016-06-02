//
//  DelegationViewController.m
//  splitViewSample
//
//  Created by Victor on 16/5/14.
//  Copyright © 2016年 NilCode. All rights reserved.
//

#import "DelegationViewController.h"


@interface DelegationViewController ()

@property (strong,nonatomic) IBOutlet UITextField *txtField;
@end

@implementation DelegationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.txtField=[[UITextField alloc]init];
    self.txtField.placeholder=@"just show something";
    self.txtField.borderStyle=UITextBorderStyleRoundedRect;
    
    
    UIButton *btnBack=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnBack setTitle:@"back" forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backAndSend:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.txtField];
    [self.view addSubview:btnBack];
    
    //add Constraint
    self.txtField.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *txtFieldTop=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:20];
    NSLayoutConstraint *txtFieldLeading=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    NSLayoutConstraint *txtFieldTrailing=[NSLayoutConstraint constraintWithItem:self.txtField attribute:NSLayoutAttributeTrailingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    
    btnBack.translatesAutoresizingMaskIntoConstraints=NO;
    NSLayoutConstraint *btnBackTop=[NSLayoutConstraint constraintWithItem:btnBack attribute:NSLayoutAttributeTopMargin relatedBy:NSLayoutRelationEqual toItem:self.txtField attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:40];
    NSLayoutConstraint *btnBackLeading=[NSLayoutConstraint constraintWithItem:btnBack attribute:NSLayoutAttributeLeadingMargin relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    
    [NSLayoutConstraint activateConstraints:@[txtFieldTop,txtFieldLeading,txtFieldTrailing,btnBackTop,btnBackLeading]];
    
}


-(IBAction)backAndSend:(id)sender{
    [self.delegate passValue:self.txtField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
